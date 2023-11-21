import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami'),
      ),
      body: Center(
        child: Text(
          'Monster Hunter adalah sebuah game aksi RPG yang dikembangkan oleh Capcom.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center, // Menambahkan textAlign untuk memusatkan teks
        ),
      ),
    );
  }
}
