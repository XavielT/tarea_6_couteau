import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> menuItems = [
    {'title': 'Predicción de Género', 'route': '/gender'},
    {'title': 'Predicción de Edad', 'route': '/age'},
    {'title': 'Universidades por país', 'route': '/universities'},
    {'title': 'Clima en RD', 'route': '/weather'},
    {'title': 'Buscar Pokémon', 'route': '/pokemon'},
    {'title': 'Noticias WordPress', 'route': '/wordpress'},
    {'title': 'Acerca de', 'route': '/about'},
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Toolbox App')),
      body: Column(
        children: [
          Image.asset('assets/toolbox.jpg'),
          Expanded(
            child: ListView(
              children: menuItems.map((item) {
                return ListTile(
                  title: Text(item['title']!),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () => Navigator.pushNamed(context, item['route']!),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
