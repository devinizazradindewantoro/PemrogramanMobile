import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// ======================================================================
/// SERVICE: FileService – Utilitas dasar untuk file handling
/// ======================================================================
class FileService {
  Future<Directory> get _documentsDirectory async {
    return await getApplicationDocumentsDirectory();
  }

  Future<File> _getFile(String fileName) async {
    final dir = await _documentsDirectory;
    return File(path.join(dir.path, fileName));
  }

  Future<File> writeFile(String fileName, String content) async {
    final file = await _getFile(fileName);
    return await file.writeAsString(content);
  }

  Future<String> readFile(String fileName) async {
    try {
      final file = await _getFile(fileName);
      return await file.readAsString();
    } catch (e) {
      return '';
    }
  }

  Future<bool> fileExists(String fileName) async {
    final file = await _getFile(fileName);
    return await file.exists();
  }

  Future<void> deleteFile(String fileName) async {
    final file = await _getFile(fileName);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

/// ======================================================================
/// SERVICE: DirectoryService – Manajemen direktori
/// ======================================================================
class DirectoryService {
  final FileService _fileService = FileService();

  Future<Directory> createDirectory(String dirName) async {
    final appDir = await _fileService._documentsDirectory;
    final newDir = Directory(path.join(appDir.path, dirName));

    if (!await newDir.exists()) {
      await newDir.create(recursive: true);
    }
    return newDir;
  }

  Future<List<FileSystemEntity>> listFiles(String dirName) async {
    final dir = await createDirectory(dirName);
    return await dir.list().toList();
  }

  Future<void> deleteDirectory(String dirName) async {
    final appDir = await _fileService._documentsDirectory;
    final dir = Directory(path.join(appDir.path, dirName));
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }
}

/// ======================================================================
/// SERVICE: NoteService – Simpan & ambil note dari file JSON
/// ======================================================================
class NoteService {
  final DirectoryService _dirService = DirectoryService();
  static const String _notesDir = 'notes';

  Future<void> saveNote({
    required String title,
    required String content,
  }) async {
    final notesDir = await _dirService.createDirectory(_notesDir);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.json';
    final file = File(path.join(notesDir.path, fileName));

    final noteData = {
      'title': title,
      'content': content,
      'created_at': DateTime.now().toIso8601String(),
    };

    await file.writeAsString(jsonEncode(noteData));
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final notesDir = await _dirService.createDirectory(_notesDir);
    final files = await notesDir.list().toList();

    final List<Map<String, dynamic>> notes = [];

    for (final entity in files) {
      if (entity is File && entity.path.endsWith('.json')) {
        final content = await entity.readAsString();
        final data = jsonDecode(content) as Map<String, dynamic>;
        data['file_path'] = entity.path;
        notes.add(data);
      }
    }

    notes.sort((a, b) =>
        b['created_at'].toString().compareTo(a['created_at'].toString()));
    return notes;
  }

  Future<void> deleteNoteByPath(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

// ============================================================================
// MAIN APP
// ============================================================================
void main() => runApp(const NotesApp());

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Lokal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const NotesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// UI: NotesPage – Halaman utama daftar catatan
// ============================================================================
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteService _noteService = NoteService();
  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _noteService.getAllNotes();
    setState(() => _notes = notes);
  }

  Future<void> _addNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddNotePage()),
    );
    if (result == true) _loadNotes();
  }

  Future<void> _deleteNote(String filePath) async {
    await _noteService.deleteNoteByPath(filePath);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Saya'),
        centerTitle: true,
      ),
      body: _notes.isEmpty
          ? const Center(child: Text('Belum ada catatan.'))
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    title: Text(note['title'] ?? 'Tanpa Judul'),
                    subtitle: Text(
                      note['content'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteNote(note['file_path']),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteDetailPage(note: note),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ============================================================================
// UI: AddNotePage – Form tambah catatan
// ============================================================================
class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final NoteService _noteService = NoteService();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan isi wajib diisi!'), backgroundColor: Colors.red),
      );
      return;
    }

    await _noteService.saveNote(title: title, content: content);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Catatan disimpan!'), backgroundColor: Colors.green),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Baru'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveNote),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
                hintText: 'Masukkan judul...',
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Isi Catatan',
                  border: OutlineInputBorder(),
                  hintText: 'Tulis di sini...',
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// UI: NoteDetailPage – Detail catatan
// ============================================================================
class NoteDetailPage extends StatelessWidget {
  final Map<String, dynamic> note;

  const NoteDetailPage({super.key, required this.note});

  String _formatDate(String isoString) {
    try {
      final date = DateTime.parse(isoString);
      return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return isoString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note['title'] ?? 'Catatan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                note['content'] ?? '',
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 24),
              if (note['created_at'] != null)
                Text(
                  'Dibuat: ${_formatDate(note['created_at'])}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}