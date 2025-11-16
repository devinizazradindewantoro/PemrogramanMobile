import 'package:flutter/material.dart';

// void main() {
//   runApp(const Tugas());
// }

// class Tugas extends StatelessWidget {
//   const Tugas({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Devin I'zaz Radin Dewantoro",
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Mata Kuliah Devin I'zaz Radin Dewantoro", style: TextStyle(fontSize: 17, fontFamily: 'Times New Roman'),
//           ),
//           backgroundColor: Colors.blueAccent,
//           foregroundColor: Colors.white,
//           centerTitle: true,
//         ),
//         body: Align(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Column(
//                   children: [
//                     Text("Balonku Ada Lima", style:TextStyle(fontWeight: FontWeight.bold)),
//                     Text("A.T. Mahmud", style:TextStyle(fontStyle: FontStyle.italic)),
//                   ],
//                 )
//               ),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text("Balonku ada lima \nRupa-rupa warnanya \nHijau, kuning, kelabu \nMerah muda dan biru"),
//                   ],
//                 )
//               ),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Meletus balon hijau"),
//                     Text("DOOOOR....", style: TextStyle(color: Colors.red)),
//                     Text("Hatiku sangat kacau \nBalonku tinggal empat \nKupegang erat-erat"),
//                     Text("\nMeletus balon hijau"),
//                     Text("DOOOOR...." , style: TextStyle(color: Colors.red)),
//                     Text("Hatiku sangat kacau \nBalonku tinggal empat \nKupegang erat-erat")
//                   ],
//                 )
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

void main() {
  runApp(const Tugas());
}

class Tugas extends StatelessWidget {
  const Tugas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Devin I'zaz Radin Dewantoro",
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Tugas1",
            style: TextStyle(fontSize: 17, fontFamily: 'Times New Roman'),
          ),
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Container(
          // 
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/gambar2.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            // padding: const EdgeInsets.all(30),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text(
                        "Terbuang Oleh Waktu",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text("Barasuara", style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\n\nTeringat seru suaramu \nMenepis keraguan \nNamun dewasa mengubah \nCara pandang dan keikhlasan \nBersaut dan bergulat \nTerperai-perai menghilang",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\nPerih yang terasa \nSakit yang tak sirna \nHarapan akankah ada \nBerputar arah",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\nAngan tenggelam dalam kabut dan amarah \nLuka terkuak dan menggebu tanpa arah \nTangis yang terbendung \nTerbuang dalam waktu \nYang meluruh",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\nPerih yang terasa \nSakit yang tak sirna \nHarapan akankah ada \nBerubah",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\nMelihatmu bersemi dan bermekaran \nTawa candamu berikan kekuatan \nSisa hariku pagi berganti waktu \nMemelukmu",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\nKita kan tua dan kehilangan pegangan \nLihat senyummu memberikan kekuatan \nSisa nafasku cinta tak kenal waktu \nMenjagamu",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}