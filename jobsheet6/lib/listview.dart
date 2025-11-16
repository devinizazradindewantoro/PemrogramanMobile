import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: listView());
  }
}

class listView extends StatelessWidget {
  final List<String> items = ['Flutter', 'Dart', 'Firebase', 'UI/UX', 'API'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView Example')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.code),
            title: Text(items[index]),
            onTap: () => print('Klik ${items[index]}'),
          );
        },
      ),
    );
  }
}