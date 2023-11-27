import 'package:flutter/material.dart';
import 'about_page.dart'; // Import AboutPage
import 'contact_page.dart'; // Import ContactPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monster Hunter Official Website',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFF4E2208), // Ganti dengan warna yang diinginkan
        leading: Image.asset(
          'assets/mhlogofix.png', // Ganti dengan path ke gambar Anda
          width: 40, // Sesuaikan lebar gambar
          height: 40, // Sesuaikan tinggi gambar
        ),
        actions: [
          Tooltip(
            message: 'About',
            child: IconButton(
              icon: Icon(Icons.notifications), // Ganti dengan ikon lonceng
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
          ),
          Tooltip(
            message: 'Contact',
            child: IconButton(
              icon: Icon(Icons.phone), // Ganti dengan ikon telepon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background4.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Hapus teks "Selamat datang di Monster Hunter Official Web!"
              // Text(
              //   'Selamat datang di Monster Hunter Official Web!',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //     shadows: [
              //       Shadow(
              //         blurRadius: 10.0,
              //         color: Color.fromRGBO(255, 255, 255, 0.3),
              //         offset: Offset(0, 0),
              //       ),
              //       Shadow(
              //         blurRadius: 10.0,
              //         color: Color.fromRGBO(255, 255, 255, 0.3),
              //         offset: Offset(0, 0),
              //       ),
              //       Shadow(
              //         blurRadius: 10.0,
              //         color: Color.fromRGBO(255, 255, 255, 0.3),
              //         offset: Offset(0, 0),
              //       ),
              //     ],
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              SizedBox(height: 350),
            ],
          ),
        ),
      ),
    );
  }
}
