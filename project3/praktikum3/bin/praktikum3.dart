import 'dart:io';

void main() {
  // 1. Growable List untuk menyimpan nama mahasiswa
  var mahasiswa = <String>[];
  for (int i = 0; i < 3; i++) {
    stdout.write("Masukkan nama mahasiswa ke-${i + 1}: ");
    var input = stdin.readLineSync();
    if (input != null && input.isNotEmpty) {
      mahasiswa.add(input);
    }
  }
  print("Daftar Mahasiswa: $mahasiswa");
  print("Jumlah mahasiswa: ${mahasiswa.length}\n");

  // 2. Union & Intersection dari 2 set
  var setA = {1, 2, 3, 4, 5};
  var setB = {4, 5, 6, 7, 8};
  print("Set A: $setA");
  print("Set B: $setB");
  print("Union: ${setA.union(setB)}");
  print("Intersection: ${setA.intersection(setB)}\n");

  // 3. Map untuk menyimpan data barang
  var barang = {
    "B01": {"nama": "Pensil", "harga": 2000},
    "B02": {"nama": "Buku", "harga": 3000},
    "B03": {"nama": "Penghapus", "harga": 1500},
  };
  print("Data Barang:");
  barang.forEach((kode, data) {
    print("Kode: $kode, Nama: ${data['nama']}, Harga: Rp${data['harga']}");
  });
  print("");

  // 4. Record untuk menyimpan data mahasiswa
  var mhs = (nim: "2341760034", nama: "Devin Izaz Radin Dewantoro", ipk: 3.74);
  print("Data Mahasiswa:");
  print("NIM: ${mhs.nim}");
  print("Nama: ${mhs.nama}");
  print("IPK: ${mhs.ipk}\n");

  // 5. Function closure untuk diskon bertingkat
  var hitungDiskon = buatDiskon();
  print("Diskon pertama: ${hitungDiskon()}%");
  print("Diskon kedua: ${hitungDiskon()}%");
  print("Diskon ketiga: ${hitungDiskon()}%");
}

Function buatDiskon() {
  int diskon = 0;
  return () {
    diskon += 5;
    return diskon;
  };
}