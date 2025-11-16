import 'package:flutter/material.dart';

void main() {
  runApp(StackExample());
}

class StackExample extends StatelessWidget {
  const StackExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Contoh Stack')),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(width: 200, height: 200, color: Colors.blue[100]),
              Container(width: 150, height: 150, color: Colors.blue[300]),
              Container(width: 100, height: 100, color: Colors.blue[800]),
              Container(width: 50, height: 50, color: Colors.blue[900]),
              Text(
                'Tumpuk!',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
