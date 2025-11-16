import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  // daftar halaman (Profil & Counter)
  final List<Widget> _pages = [
    const ProfilPage(),
    const CounterPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Profile & Counter App",
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            _selectedIndex == 0 ? "Profil Mahasiswa" : "Counter App",
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Times New Roman',
            ),
          ),
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: "Counter",
            ),
          ],
        ),
      ),
    );
  }
}

// ================== HALAMAN PROFIL ===================
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blueGrey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FlutterLogo(size: 80),
          const SizedBox(height: 20),
          // foto profil
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage("assets/devin.jpg"),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.blueGrey, width: 2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Devin I'zaz Radin Dewantoro",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            "NIM: 2341760034",
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            "Jurusan: Teknologi Informasi",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.email, color: Colors.blueGrey),
              SizedBox(width: 5),
              Text("devinizazradindewantoro@gmail.com"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.phone, color: Colors.blueGrey),
              SizedBox(width: 5),
              Text("+6281335729933"),
            ],
          ),
        ],
      ),
    );
  }
}

// ================== HALAMAN COUNTER ===================
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$_counter",
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _increment,
                child: const Text("+"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _decrement,
                child: const Text("-"),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: _reset,
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
