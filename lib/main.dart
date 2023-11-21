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
              // Teks berpendar (glowing) dengan kontras yang diturunkan
              Text(
                'Selamat datang di Monster Hunter!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromRGBO(255, 255, 255, 0.3), // Red, Green, Blue, Opacity
                      offset: Offset(0, 0),
                    ),
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                      offset: Offset(0, 0),
                    ),
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 350),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
                child: Text('Tentang Kami'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage()),
                  );
                },
                child: Text('Hubungi Kami'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
