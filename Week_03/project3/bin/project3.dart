import 'dart:io';

import 'package:project3/project3.dart' as project3;

void main(List<String> arguments) {
  //print('Hello world: ${project3.calculate()}!');

  // Belajar Fixed List
  // var list = List<int>.filled(5, 0);

  // list[0] = 10;
  // list[1] = 20;
  // list[2] = 30;
  // list[3] = 40;
  // list[4] = 50;
  // //list[5] = 60; // list tidak masuk dalam ruang
  // print("Data dalam list = $list");

  // // List fixed list menggunakan perulangan
  // for (int i = 0; i <= 4; i++) {
  //   stdout.write('Masukkan data ke-$i : ');
  //   var input = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  //   list[i] = input!;
  // }
  // stdout.writeln("Data dalam list: $list");

  // Growable list
  // var grow = [10];
  // grow.add(20);
  // grow.add(30);
  // grow.add(40);
  // grow.remove(10);
  // grow.add(10);

  // stdout.writeln("Data didalam list: $grow");

  // for (var i = 0; i <= 4; i++) {
  //   stdout.write('Masukkan data ke-$i : ');
  //   var input = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  //   list[i] = input!;
  // }
  // stdout.writeln("Data dalam list: $list");

  // print('data dalam grow list');
  // var grow = [];

  // for (var i = 0; i <= 4; i++) {
  //   stdout.write('data list ke- $i: ');
  //   var input = stdin.readByteSync();
  //   if (input != null) {
  //     grow.add(input);
  //     print('data index ke: $i ${grow[i]}');
  //   }
  // }
  // print('data dalam list: $grow');

  // Set
  // var angka = <int>[1, 2, 3, 4, 5];
  // print("Data nya adalah: ${angka.elementAt(3)}");

  // var angka2 = <int>{4, 5, 6, 7, 8};
  // print("Data union adalah =  ${angka.union(angka2)}");
  // print("Data intersection adalah = ${angka.intersection(angka2)}");

  // Map
  // var biodata = {
  //   "Nim": "2341760034",
  //   "Nama": "Devin",
  //   "Jurusan": "Teknologi Informasi",
  //   "Nama" : "Devin",
  // };
  // biodata['Nama'] = "2023";
  // print("Biodata Mahasiswa ${biodata['Nama']}");

  // Record
  // var mahasiswa = ("Luqman", 40, true);
  // print("Ini data pak Luqman : $mahasiswa");
  // print("Mahasiswa : ${mahasiswa.$3}");

  // var biodata = (Nama: "Devin", Umur: 21, JenisKelamin: true);
  // print("Biodata saya : $biodata");
  // print("Nama saya: ${biodata.Nama}");

  // Function Parameter
  // tampil("Devin", 21, "Pasuruan");
  // tampil("Devin", 21);

  // Anonimus Function
  var nilai = [90, 80, 70, 100];
  for (var angka in nilai) {
    print("Nilai = $angka");
  }
}

// void tampil(String nama, int umur, [String? alamat]) {
//   print("Nama : $nama");
//   print("Umur : $umur");
//   if (alamat != null) {
//     print("Alamat : $alamat");
//   } else {
//     print("Alamat : -");
//   }
// }
