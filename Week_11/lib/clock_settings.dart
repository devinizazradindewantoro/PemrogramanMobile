import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ClockSettingsScreen extends StatefulWidget {
  const ClockSettingsScreen({super.key});

  @override
  State<ClockSettingsScreen> createState() => _ClockSettingsScreenState();
}

class _ClockSettingsScreenState extends State<ClockSettingsScreen> {
  List shifts = [];
  final String baseUrl = "http://localhost:8000/api/check-clock-settings/";

  @override
  void initState() {
    super.initState();
    fetchShifts();
  }
  ///
  Future<void> fetchShifts() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      setState(() => shifts = json.decode(res.body));
    }
  }

  Future<void> addShift(String name, int type) async {
    await http.post(Uri.parse(baseUrl), body: {'name': name, 'type': '$type'});
    fetchShifts();
  }

  Future<void> updateShift(int id, String name, int type) async {
    await http.put(Uri.parse("$baseUrl$id"), body: {'name': name, 'type': '$type'});
    fetchShifts();
  }

  Future<void> deleteShift(int id) async {
    await http.delete(Uri.parse("$baseUrl$id"));
    fetchShifts();
  }

  void showShiftDialog({Map? shift}) {
    final nameController = TextEditingController(text: shift?['name'] ?? '');
    final typeController = TextEditingController(text: shift?['type']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(shift == null ? 'Tambah Shift' : 'Edit Shift'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nama Shift')),
            TextField(controller: typeController, decoration: const InputDecoration(labelText: 'Tipe Shift'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (shift == null) {
                addShift(nameController.text, int.parse(typeController.text));
              } else {
                updateShift(shift['id'], nameController.text, int.parse(typeController.text));
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
      floatingActionButton: FloatingActionButton(onPressed: () => showShiftDialog(), child: const Icon(Icons.add)),
      body: ListView.builder(
        itemCount: shifts.length,
        itemBuilder: (_, i) {
          final shift = shifts[i];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(shift['name']),
              subtitle: Text('Type: ${shift['type']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: () => showShiftDialog(shift: shift)),
                  IconButton(icon: const Icon(Icons.delete), onPressed: () => deleteShift(shift['id'])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
