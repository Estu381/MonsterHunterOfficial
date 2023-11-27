import 'dart:async';
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> slideImages = [
    'assets/slide1.png',
    'assets/slide2.png',
    'assets/slide3.png',
    'assets/slide4.png',
    'assets/slide5.png',
    'assets/slide6.png',
    'assets/slide7.png',
    'assets/slide8.png',
  ];

  final List<String> gameImages = [
    'assets/mhn.png',
    'assets/mhgu.png',
    'assets/mhw.png',
    'assets/mhwi.png',
    'assets/rise.png',
    'assets/rise2.png',
    'assets/stories.png',
    // ... tambahkan path gambar game yang lain sesuai kebutuhan
  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < slideImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFF4E2208),
        leading: Image.asset(
          'assets/mhlogofix.png',
          width: 40,
          height: 40,
        ),
        actions: [
          Tooltip(
            message: 'About',
            child: IconButton(
              icon: Icon(Icons.notifications),
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
              icon: Icon(Icons.phone),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Slideshow menggunakan PageView
            Container(
              height: 185.0,
              color: Colors.purple[100], // Warna latar belakang purple light
              child: PageView.builder(
                controller: _pageController,
                itemCount: slideImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width, // Lebar layar
                    margin: EdgeInsets.symmetric(horizontal: 0.0),
                    child: Image.asset(
                      slideImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
            // Teks "OUR GAMES" di luar PageView pada latar belakang hitam
            Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  '**OUR GAMES**',
                  style: TextStyle(
                    color: Colors.white, // Warna teks putih
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
            ),
            // GridView untuk menampilkan gambar game dengan lebar 1/3 dari lebar layar
            Container(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: gameImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 3 - 16.0,
                    height: MediaQuery.of(context).size.width / 3 - 16.0,
                    child: Image.asset(
                      gameImages[index],
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            // Konten lainnya di bawah slideshow
            Container(
              color: Colors.black,
              // Gantilah dengan konten atau widget lain yang diinginkan
              child: Center(
                child: Text(
                  '', // Kosongkan teks
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
