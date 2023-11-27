import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami'),
      ),
      body: Container(
        color: Colors.black, // Set warna background menjadi hitam
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20), // Jarak atas untuk teks
            Center(
              child: Text(
                'Monster Hunter adalah sebuah game aksi RPG yang dikembangkan oleh Capcom.',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
