import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SalariesScreen extends StatefulWidget {
  const SalariesScreen({super.key});

  @override
  State<SalariesScreen> createState() => _SalariesScreenState();
}

class _SalariesScreenState extends State<SalariesScreen> {
  List salaries = [];
  final String baseUrl = "http://localhost:8000/api/salaries/";

  @override
  void initState() {
    super.initState();
    fetchSalaries();
  }

  Future<void> fetchSalaries() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      setState(() => salaries = json.decode(res.body));
    }
  }

  Future<void> addSalary(int userId, int rate, String date, int type) async {
    await http.post(Uri.parse(baseUrl), body: {
      'user_id': '$userId',
      'rate': '$rate',
      'effective_date': date,
      'type': '$type'
    });
    fetchSalaries();
  }

  Future<void> updateSalary(int id, int userId, int rate, String date, int type) async {
    await http.put(Uri.parse("$baseUrl$id"), body: {
      'user_id': '$userId',
      'rate': '$rate',
      'effective_date': date,
      'type': '$type'
    });
    fetchSalaries();
  }

  Future<void> deleteSalary(int id) async {
    await http.delete(Uri.parse("$baseUrl$id"));
    fetchSalaries();
  }

  void showSalaryDialog({Map? salary}) {
    final userIdController = TextEditingController(text: salary?['user_id']?.toString() ?? '');
    final rateController = TextEditingController(text: salary?['rate']?.toString() ?? '');
    final dateController = TextEditingController(text: salary?['effective_date'] ?? '');
    final typeController = TextEditingController(text: salary?['type']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(salary == null ? 'Tambah Gaji' : 'Edit Gaji'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: userIdController, decoration: const InputDecoration(labelText: 'User ID')),
            TextField(controller: rateController, decoration: const InputDecoration(labelText: 'Rate'), keyboardType: TextInputType.number),
            TextField(controller: typeController, decoration: const InputDecoration(labelText: 'Type'), keyboardType: TextInputType.number),
            TextField(controller: dateController, decoration: const InputDecoration(labelText: 'Effective Date (YYYY-MM-DD)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (salary == null) {
                addSalary(
                  int.parse(userIdController.text),
                  int.parse(rateController.text),
                  dateController.text,
                  int.parse(typeController.text),
                );
              } else {
                updateSalary(
                  salary['id'],
                  int.parse(userIdController.text),
                  int.parse(rateController.text),
                  dateController.text,
                  int.parse(typeController.text),
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => showSalaryDialog(), child: const Icon(Icons.add)),
      body: ListView.builder(
        itemCount: salaries.length,
        itemBuilder: (_, i) {
          final s = salaries[i];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('User: ${s['user']?['email'] ?? 'Unknown'}'),
              subtitle: Text('Rate: ${s['rate']} - Type: ${s['type']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: () => showSalaryDialog(salary: s)),
                  IconButton(icon: const Icon(Icons.delete), onPressed: () => deleteSalary(s['id'])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
