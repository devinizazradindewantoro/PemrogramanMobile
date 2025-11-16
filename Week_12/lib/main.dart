import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// ======================================================================
/// SERVICE: FileService – Operasi dasar baca/tulis file JSON
/// ======================================================================
class FileService {
  Future<Directory> get _documentsDirectory async {
    return await getApplicationDocumentsDirectory();
  }

  Future<File> _getFile(String fileName) async {
    final dir = await _documentsDirectory;
    return File(path.join(dir.path, fileName));
  }

  /// Simpan string ke file
  Future<File> writeFile(String fileName, String content) async {
    final file = await _getFile(fileName);
    return await file.writeAsString(content);
  }

  /// Baca string dari file
  Future<String> readFile(String fileName) async {
    try {
      final file = await _getFile(fileName);
      return await file.readAsString();
    } catch (e) {
      return '';
    }
  }

  /// Simpan Map sebagai JSON
  Future<File> writeJson(String fileName, Map<String, dynamic> json) async {
    return await writeFile(fileName, jsonEncode(json));
  }

  /// Baca JSON dari file
  Future<Map<String, dynamic>> readJson(String fileName) async {
    try {
      final content = await readFile(fileName);
      if (content.isEmpty) return {};
      return jsonDecode(content) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  /// Cek apakah file ada
  Future<bool> fileExists(String fileName) async {
    final file = await _getFile(fileName);
    return await file.exists();
  }

  /// Hapus file
  Future<void> deleteFile(String fileName) async {
    try {
      final file = await _getFile(fileName);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Error deleting file: $e');
    }
  }
}

/// ======================================================================
/// SERVICE: UserDataService – Simpan & baca data user dari JSON
/// ======================================================================
class UserDataService {
  final FileService _fileService = FileService();
  static const String _fileName = 'user_data.json';

  Future<void> saveUserData({
    required String name,
    required String email,
    int? age,
  }) async {
    final userData = {
      'name': name,
      'email': email,
      'age': age ?? 0,
      'last_update': DateTime.now().toIso8601String(),
    };
    await _fileService.writeJson(_fileName, userData);
  }

  Future<Map<String, dynamic>?> readUserData() async {
    final exists = await _fileService.fileExists(_fileName);
    if (!exists) return null;

    final data = await _fileService.readJson(_fileName);
    return data.isNotEmpty ? data : null;
  }

  Future<void> deleteUserData() async {
    await _fileService.deleteFile(_fileName);
  }

  Future<bool> hasUserData() async {
    return await _fileService.fileExists(_fileName);
  }
}

// ============================================================================
// MAIN APP
// ============================================================================
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Data JSON Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const UserProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// UI: UserProfilePage
// ============================================================================
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserDataService _userService = UserDataService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Map<String, dynamic>? _savedData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  /// Memuat data dari file JSON
  Future<void> _loadUserData() async {
    final data = await _userService.readUserData();
    setState(() => _savedData = data);
  }

  /// Simpan data ke file JSON
  Future<void> _saveUserData() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final age = int.tryParse(_ageController.text);

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan Email wajib diisi')),
      );
      return;
    }

    await _userService.saveUserData(name: name, email: email, age: age);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil disimpan')),
    );
    await _loadUserData();
  }

  /// Hapus data user
  Future<void> _deleteUserData() async {
    await _userService.deleteUserData();
    setState(() => _savedData = null);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data user dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil User (File JSON)'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // === FORM INPUT ===
            _buildTextField(_nameController, 'Nama'),
            const SizedBox(height: 12),
            _buildTextField(_emailController, 'Email'),
            const SizedBox(height: 12),
            _buildTextField(
              _ageController,
              'Usia',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),

            // === BUTTONS ===
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Simpan'),
                    onPressed: _saveUserData,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete),
                    label: const Text('Hapus'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: _deleteUserData,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            const Divider(),

            // === TAMPILAN DATA TERSIMPAN ===
            _savedData == null
                ? const Text(
                    'Belum ada data tersimpan.',
                    style: TextStyle(color: Colors.grey),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Tersimpan:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDataRow('Nama', _savedData!['name'].toString()),
                      _buildDataRow('Email', _savedData!['email'].toString()),
                      _buildDataRow('Usia', _savedData!['age'].toString()),
                      _buildDataRow('Update Terakhir', _savedData!['last_update'].toString()),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  /// Helper: TextField dengan style konsisten
  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }

  /// Helper: Menampilkan satu baris data (label: value)
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}