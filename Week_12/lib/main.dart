import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ========================================
// CONFIG: API Settings
// ========================================
class ApiConfig {
  static const String baseUrl = 'https://laffandi.wiremockapi.cloud';
  static const String usersEndpoint = '/users';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

// ========================================
// MAIN APP
// ========================================
void main() => runApp(const WireMockApp());

class WireMockApp extends StatelessWidget {
  const WireMockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WireMock Cloud Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const UserPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ========================================
// UI: UserPage – CRUD dengan WireMock
// ========================================
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  List<dynamic> users = [];
  bool isLoading = false;
  String? errorMessage;
  String? postMessage;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // ========================================
  // GET: Fetch all users
  // ========================================
  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.usersEndpoint}');

    try {
      final response = await http
          .get(url, headers: ApiConfig.headers)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() => users = data is List ? data : []);
      } else {
        setState(() => errorMessage = 'Error ${response.statusCode}');
      }
    } catch (e) {
      setState(() => errorMessage = 'Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // ========================================
  // POST: Add new user
  // ========================================
  Future<void> addUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      _showSnackBar('Nama & Email tidak boleh kosong!', Colors.red);
      return;
    }

    final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.usersEndpoint}');
    final body = jsonEncode({'name': name, 'email': email});

    try {
      final response = await http
          .post(url, headers: ApiConfig.headers, body: body)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        final message = result['message'] ?? 'User berhasil ditambahkan!';

        setState(() => postMessage = message);
        _showSnackBar(message, Colors.green);

        _nameController.clear();
        _emailController.clear();
        fetchUsers();
      } else {
        final msg = 'Gagal menambah user (${response.statusCode})';
        setState(() => postMessage = msg);
        _showSnackBar(msg, Colors.red);
      }
    } catch (e) {
      final msg = 'Error: $e';
      setState(() => postMessage = msg);
      _showSnackBar(msg, Colors.red);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  // ========================================
  // UI: Build method
  // ========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WireMock Cloud - Users'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // === Form Input ===
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Tambah User'),
              onPressed: addUser,
            ),
            const SizedBox(height: 20),

            // === Feedback POST ===
            if (postMessage != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  postMessage!,
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
            ],

            const Text(
              'Daftar User',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),

            // === Data List ===
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage != null
                      ? Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.red)))
                      : users.isEmpty
                          ? const Center(child: Text('Belum ada data.'))
                          : ListView.builder(
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                final user = users[index];
                                return Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text(user['id']?.toString() ?? '?'),
                                    ),
                                    title: Text(user['name'] ?? 'Tanpa Nama'),
                                    subtitle: Text(user['email'] ?? 'Tanpa Email'),
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}