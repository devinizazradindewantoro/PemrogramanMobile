import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersHrisScreen extends StatefulWidget {
  const UsersHrisScreen({super.key});

  @override
  State<UsersHrisScreen> createState() => _UsersHrisScreenState();
}

class _UsersHrisScreenState extends State<UsersHrisScreen> {
  List users = [];
  final String baseUrl = "http://localhost:8000/api/users-hris/";

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      setState(() => users = json.decode(res.body));
    }
  }

  Future<void> addUser(String email, bool isAdmin) async {
    await http.post(Uri.parse(baseUrl), body: {
      'email': email,
      'is_admin': isAdmin ? '1' : '0',
      'password': 'default123'
    });
    fetchUsers();
  }

  Future<void> updateUser(int id, String email, bool isAdmin) async {
    await http.put(Uri.parse("$baseUrl$id"), body: {
      'email': email,
      'is_admin': isAdmin ? '1' : '0',
    });
    fetchUsers();
  }

  Future<void> deleteUser(int id) async {
    await http.delete(Uri.parse("$baseUrl$id"));
    fetchUsers();
  }

  void showUserDialog({Map? user}) {
    final emailController = TextEditingController(text: user?['email'] ?? '');
    bool isAdmin = (user?['is_admin'] ?? 0) == 1;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(user == null ? 'Tambah User' : 'Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            SwitchListTile(
              value: isAdmin,
              onChanged: (v) => setState(() => isAdmin = v),
              title: const Text("Admin"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (user == null) {
                addUser(emailController.text, isAdmin);
              } else {
                updateUser(user['id'], emailController.text, isAdmin);
              }
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showUserDialog(),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, i) {
          final user = users[i];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(user['email']),
              subtitle: Text(user['is_admin'] == 1 ? 'Admin' : 'User'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: () => showUserDialog(user: user)),
                  IconButton(icon: const Icon(Icons.delete), onPressed: () => deleteUser(user['id'])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
