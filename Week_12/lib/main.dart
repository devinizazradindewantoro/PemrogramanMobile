import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ========================================
// CONFIG: API Base URL
// ========================================
class ApiConfig {
  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static const String dittoEndpoint = '/pokemon/ditto'; // Bisa diganti
}

// ========================================
// MAIN APP
// ========================================
void main() => runApp(const PokeApp());

class PokeApp extends StatelessWidget {
  const PokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI – Ditto',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const PokemonPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ========================================
// UI: PokemonPage
// ========================================
class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  Map<String, dynamic>? pokemonData;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  // ========================================
  // FETCH: Ambil data dari PokeAPI
  // ========================================
  Future<void> fetchPokemon() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.dittoEndpoint}');

    try {
      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          pokemonData = data;
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Gagal memuat data. Status: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Terjadi kesalahan: $e';
        isLoading = false;
      });
    }
  }

  // ========================================
  // UI: Build Pokémon Card
  // ========================================
  Widget _buildPokemonCard() {
    final name = pokemonData?['name'] ?? 'Unknown';
    final id = pokemonData?['id'] ?? '-';
    final height = pokemonData?['height'] ?? '-';
    final weight = pokemonData?['weight'] ?? '-';
    final sprite = pokemonData?['sprites']?['front_default'] ??
        'https://via.placeholder.com/150';

    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sprite
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                sprite,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 160,
                  height: 160,
                  color: Colors.grey[300],
                  child: const Icon(Icons.crisis_alert, size: 60, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Name
            Text(
              name.toString().toUpperCase(),
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),

            // Stats
            _buildInfoRow('ID', '#${id.toString().padLeft(3, '0')}'),
            _buildInfoRow('Height', '$height dm'),
            _buildInfoRow('Weight', '$weight hg'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }

  // ========================================
  // UI: Build Method
  // ========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeAPI – Ditto'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : error != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 60),
                      const SizedBox(height: 16),
                      Text(
                        error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ],
                  )
                : pokemonData == null
                    ? const Text('Tidak ada data')
                    : _buildPokemonCard(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchPokemon,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}