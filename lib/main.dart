import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/gender_screen.dart';
import 'screens/age_screen.dart';
import 'screens/universities_screen.dart';
import 'screens/weather_screen.dart';
import 'screens/pokemon_screen.dart';
import 'screens/wordpress_screen.dart';
import 'screens/about_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toolbox App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/gender': (context) => GenderScreen(),
        '/age': (context) => AgeScreen(),
        '/universities': (context) => UniversitiesScreen(),
        '/weather': (context) => WeatherScreen(),
        '/pokemon': (context) => PokemonScreen(),
        '/wordpress': (context) => WordPressScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
