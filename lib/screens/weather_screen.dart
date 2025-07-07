import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey = 'TU_API_KEY'; // ← Cambia esto por tu clave real
  String city = 'Santo Domingo';
  String condition = '';
  double temperature = 0;
  String iconUrl = '';

  Future<void> fetchWeather() async {
    final url =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&lang=es';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        condition = data['current']['condition']['text'];
        temperature = data['current']['temp_c'];
        iconUrl = "https:${data['current']['condition']['icon']}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clima en RD')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconUrl.isNotEmpty) Image.network(iconUrl, height: 100),
            Text('Ciudad: $city'),
            Text('Temperatura: ${temperature.toStringAsFixed(1)}°C'),
            Text('Condición: $condition'),
          ],
        ),
      ),
    );
  }
}
