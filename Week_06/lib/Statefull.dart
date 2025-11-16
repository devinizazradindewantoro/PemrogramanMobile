import 'package:flutter/material.dart';

void main() {
  runApp(const GantiWarnaApp());
}

class GantiWarnaApp extends StatefulWidget {
  const GantiWarnaApp({super.key});

  @override
  State<GantiWarnaApp> createState() => _GantiWarnaAppState();
}

class _GantiWarnaAppState extends State<GantiWarnaApp> {
  bool _isBlue = true; // ubah nilai state

  void _ubahWarna() {
    setState(() {
      _isBlue = !_isBlue; // ubah nilai state
    });
  }

  void _ubahWarna1() {
    setState(() {
      _isBlue = !_isBlue; // ubah nilai state
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Contoh Stateful Widget'),
        ),
        backgroundColor: _isBlue ? Colors.blue[800] : Colors.pink[800],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Halo, saya Stateful Widget!',
                style: TextStyle(
                  fontSize: 24,
                  color: _isBlue ? Colors.blue[800] : Colors.pink[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _ubahWarna,
                child: const Text('Ubah Warna'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}