import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class WordPressScreen extends StatefulWidget {
  const WordPressScreen({super.key});

  @override
  _WordPressScreenState createState() => _WordPressScreenState();
}

class _WordPressScreenState extends State<WordPressScreen> {
  List posts = [];

  Future<void> fetchPosts() async {
    final url = 'https://demo.wp-api.org/wp-json/wp/v2/posts';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void openUrl(String link) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Noticias WordPress')),
      body: ListView.builder(
        itemCount: posts.length > 3 ? 3 : posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final title = post['title']['rendered'];
          final content = post['excerpt']['rendered']
              .replaceAll(RegExp(r'<[^>]*>'), ''); // Quita HTML
          return ListTile(
            leading: Image.asset('assets/wordpress_logo.png', height: 40),
            title: Text(title),
            subtitle: Text(content),
            onTap: () => openUrl(post['link']),
          );
        },
      ),
    );
  }
}
