import 'dart:io';

void main() {
  //print('coba');
  print("Masukkan angka hari =");
  String? hari = stdin.readLineSync();
  int nilai = int.tryParse(hari ?? '') ?? 0;
  switch (nilai) {
    case 1:
      print("Senin");
      break;
    case 2:
      print("Selasa");
      break;
    case 3:
      print("Rabu");
      break;
    default:
      print("Maaf inputan salah");
  }
}
