import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String name = '';
  String gender = '';
  Color backgroundColor = Colors.white;

  Future<void> predictGender() async {
    final url = 'https://api.genderize.io/?name=$name';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        gender = data['gender'] ?? 'desconocido';
        backgroundColor = gender == 'male' ? Colors.blue[100]! : Colors.pink[100]!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text('Predicción de Género')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nombre'),
              onChanged: (value) => name = value,
            ),
            ElevatedButton(
              onPressed: predictGender,
              child: Text('Predecir género'),
            ),
            SizedBox(height: 20),
            Text('Género: $gender'),
          ],
        ),
      ),
    );
  }
}
