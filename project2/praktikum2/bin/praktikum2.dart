import 'dart:io';

import 'package:praktikum2/praktikum2.dart' as praktikum2;

void main(List<String> arguments) {
  //print('Hello world: ${praktikum2.calculate()}!');
  // List untuk menyimpan data mahasiswa
  List<Map<String, dynamic>> daftarMahasiswa = [];

  // Perulangan untuk input 5 mahasiswa
  for (int i = 1; i <= 5; i++) {
    stdout.writeln("\nMahasiswa ke-$i");

    // Input nama mahasiswa
    stdout.write("Masukkan nama: ");
    String? nama = stdin.readLineSync();

    // Input nilai mahasiswa
    stdout.write("Masukkan nilai: ");
    int nilai = int.parse(stdin.readLineSync()!);

    // Tentukan kategori berdasarkan nilai
    String kategori;
    if ((nilai >= 80) && (nilai <= 100)){
      kategori = "A (Lulus)";
    } else if ((nilai >= 60) && (nilai <= 79)) {
      kategori = "B (Lulus)";
    } else {
      kategori = "C (Tidak Lulus)";
    }

    // Simpan ke list
    daftarMahasiswa.add({
      "nama": nama ?? "Tanpa Nama",
      "nilai": nilai,
      "kategori": kategori,
    });
  }

  // Tampilkan hasil akhir
  stdout.writeln("\n=== Daftar Mahasiswa dan Kategori ===");
  for (var mhs in daftarMahasiswa) {
    stdout.writeln(
      "Nama: ${mhs['nama']}, Nilai: ${mhs['nilai']}, Kategori: ${mhs['kategori']}",
    );
  }
}
