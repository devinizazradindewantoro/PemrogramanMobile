import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final List<String> mataKuliah = [
    'Perencanaan Sumber Daya',
    'Pemrograman Mobile',
    'Kesehatan dan Keselamatan Kerja',
    'Metodologi Penelitian',
    'Penjamin Mutu Perangkat Lunak',
    'Manajemen Proyek Sistem Informasi',
    'Kecerdasan Buatan',
    'Manajemen Rantai Pasok',
    'Audit Sistem Informasi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Mahasiswa'),
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(fontSize: 20),
        elevation: 0,
        ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/devin.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama: Devin I'zaz Radin Dewantoro"),
                    Text('NIM: 2341760034'),
                    Text('Program Studi: D-IV Sistem Informasi Bisnis'),
                    Text('Email: devinizazradindewantoro@gmail.com'),
                    Text('Nomor: +6281335729933'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: mataKuliah.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.book),
                    title: Text(mataKuliah[index]),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gallery');
              },
              child: Text('Lihat Galeri'),
            ),
          ],
        ),
      ),
    );
  }
}
