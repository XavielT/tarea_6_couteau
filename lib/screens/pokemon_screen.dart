import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  String name = '';
  String image = '';
  int baseExp = 0;
  List<String> abilities = [];
  final player = AudioPlayer();

  Future<void> fetchPokemon() async {
    final url = 'https://pokeapi.co/api/v2/pokemon/$name';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        image = data['sprites']['front_default'];
        baseExp = data['base_experience'];
        abilities = (data['abilities'] as List)
            .map((e) => e['ability']['name'].toString())
            .toList();
      });

      // Reproduce un sonido local (ponlo en assets/audio/pokemon.mp3)
      await player.play(AssetSource('audio/pokemon.mp3'));
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar Pokémon')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nombre del Pokémon'),
              onChanged: (value) => name = value.toLowerCase(),
            ),
            ElevatedButton(
              onPressed: fetchPokemon,
              child: Text('Buscar'),
            ),
            if (image.isNotEmpty) ...[
              Image.network(image, height: 100),
              Text('Experiencia base: $baseExp'),
              Text('Habilidades: ${abilities.join(', ')}'),
            ]
          ],
        ),
      ),
    );
  }
}
