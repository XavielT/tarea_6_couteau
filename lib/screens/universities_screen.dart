import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  String country = '';
  List universities = [];

  Future<void> fetchUniversities() async {
    final url = 'http://universities.hipolabs.com/search?country=${country.replaceAll(' ', '+')}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        universities = json.decode(response.body);
      });
    }
  }

  void openLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Universidades')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nombre del país (en inglés)'),
              onChanged: (value) => country = value,
            ),
            ElevatedButton(
              onPressed: fetchUniversities,
              child: Text('Buscar'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  final uni = universities[index];
                  return ListTile(
                    title: Text(uni['name']),
                    subtitle: Text(uni['domains'].join(', ')),
                    onTap: () => openLink(uni['web_pages'][0]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
