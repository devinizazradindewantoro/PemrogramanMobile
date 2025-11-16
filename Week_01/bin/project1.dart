import 'dart:io';

import 'package:project1/project1.dart' as project1;

const String nama = 'Devin';

void main(List<String> arguments) {
  //print('Hello world: ${project1.calculate()}!');
  //satu line comment
  /*
  multi line comment
  */

  //constanta dan final
  final String nama2 = 'Radin';
  print("Nama saya $nama $nama2");

  //variabel
  int umur = 20;
  double tinggi = 175.5;
  bool jenisKelamin = false; //true = laki-laki, false = perempuan
  String alamat = 'Jl. Merdeka No. 45';
  stdout.writeln("Umur saya $umur tahun");
  stdout.writeln("Tinggi saya $tinggi cm");
  //stdout.writeln(
  //  "Jenis kelamin saya ${jenis_kelamin ? 'Laki-laki' : 'Perempuan'}",
  //);
  if (jenisKelamin == false) {
    stdout.writeln("Jenis kelamin saya Laki-laki");
  } else {
    stdout.writeln("Jenis kelamin saya Perempuan");
  }
  stdout.writeln("Alamat saya $alamat");

  num nilai = 90.5; //bisa diisi int atau double
  stdout.writeln("Nilai saya $nilai");
  dynamic bebas = 16;
  stdout.writeln("Nilai dari dynamic adalah $bebas");
  String angka1 = "15";
  int angka2 = int.parse(angka1);
  int angka3 = bebas;

  // list
  List<String> hobby = ["Mancing", "Tidur", "Ngoding"];
  hobby.add("Shopping");
  stdout.writeln("Hobby saya adalah $hobby");
  Map<String, String> data = {
    "nama": "Dian",
    "alamat": "Malang",
    "jenis kelamin": "Perempuan",
  };
  data["pekerjaan"] = "Dosen";
  data.addAll({"hobi": "Membaca"});

  stdout.writeln("Data : $data");
  stdout.writeln("Nama yang ada di data ${data['nama']}");

  // Try Catch
  try {
    int result = 10 ~/ 0;
  } on IntegerDivisionByZeroException {
    print("Cannot divide by zero!");
  } catch (e) {
    print("An unexpected error occurred: $e");
  } finally {
    print("Execution complete.");
  }

  // Null Safety
  String ? kendaraan;
  stdout.write("Kendaraan $kendaraan");
}
