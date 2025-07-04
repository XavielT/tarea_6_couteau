import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  String name = '';
  int? age;
  String label = '';
  String image = '';

  Future<void> predictAge() async {
    final url = 'https://api.agify.io/?name=$name';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final ageVal = data['age'] ?? 0;

      String status = '';
      String img = '';
      if (ageVal < 18) {
        status = 'Joven';
        img = 'assets/young.png';
      } else if (ageVal <= 60) {
        status = 'Adulto';
        img = 'assets/adult.png';
      } else {
        status = 'Anciano';
        img = 'assets/old.png';
      }

      setState(() {
        age = ageVal;
        label = status;
        image = img;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Predicción de Edad')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nombre'),
              onChanged: (value) => name = value,
            ),
            ElevatedButton(
              onPressed: predictAge,
              child: Text('Predecir edad'),
            ),
            if (age != null) ...[
              SizedBox(height: 20),
              Text('Edad estimada: $age'),
              Text('Clasificación: $label'),
              Image.asset(image, height: 100),
            ]
          ],
        ),
      ),
    );
  }
}
