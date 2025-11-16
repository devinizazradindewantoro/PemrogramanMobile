import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final List<Map<String, String>> galleryItems = [
    {'title': 'Perencanaan Sumber Daya', 'image': 'assets/psd1.jpeg'},
    {'title': 'Pemrograman Mobile', 'image': 'assets/pm1.jpeg'},
    {'title': 'Kesehatan & Keselamatan Kerja', 'image': 'assets/K31.jpeg'},
    {'title': 'Metodologi Penelitian', 'image': 'assets/metpen.jpeg'},
    {'title': 'Penjamin Mutu Perangkat Lunak', 'image': 'assets/pmpl1.jpeg'},
    {'title': 'Manajemen Proyek Sistem Informasi', 'image': 'assets/manpro1.jpeg'},
    {'title': 'Kecerdasan Bisnis', 'image': 'assets/kecbis1.jpeg'},
    {'title': 'Manajemen Rantai Pasok', 'image': 'assets/mrp.jpeg'},
    {'title': 'Audit Sistem Informasi', 'image': 'assets/audsi1.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeri Mahasiswa'),
        titleTextStyle: TextStyle(fontSize: 20),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: galleryItems.length,
          itemBuilder: (context, index) {
            final item = galleryItems[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      item['image']!,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
