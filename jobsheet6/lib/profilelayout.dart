import 'package:flutter/material.dart';

void main() {
  runApp(ProfileLayout());
}

class ProfileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Layout Profil')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/devin.jpg"),
          ),
          SizedBox(height: 10),
          Text(
            'Devin Izaz Radin Dewantoro',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text('Flutter Developer', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}