import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Acerca de')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/xaviel_foto.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              'Xaviel Terrero',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Matrícula: 2021-2362'),
            Text('Email: xavieljoseterrerocuevas9@gmail.com'),
            Text('Teléfono: +1 (809) 779-9782'),
          ],
        ),
      ),
    );
  }
}
