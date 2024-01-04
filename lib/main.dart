import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mhofficial/admin_page.dart';
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

  final List<String> newsImages = [
    'assets/news1.png',
    'assets/news2.png',
    'assets/news3.png',
    'assets/news4.png',
    'assets/news5.png',
    // ... tambahkan path gambar berita yang lain sesuai kebutuhan
  ];

  final List<String> newsContents = [
    'New design coming to official Capcom apparel on Amazon!',
    'Vote for your favorite monster in the Hunters choice (Top Monster)!',
    'Monster Hunter Rise: Sunbreak All Title Update Out Now!',
    'MONSTER HUNTER RISE (Xbox Series X|S/Xbox One/Windows/PS5/PS4) ',
    'Monster Hunter Rise: Sunbreak Roadmap Free Title Updates',
  ];

  final List<String> newsHeadlines = [
    'Latest News Headline 1',
    'Latest News Headline 2',
    'Latest News Headline 3',
    'Latest News Headline 4',
    'Latest News Headline 5',
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
            message: 'About',
            child: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminPage(
                      slideImages: slideImages,
                      gameImages: gameImages, // Pastikan parameter ini diisi
                    ),
                  ),
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
                  return GestureDetector(
                    onTap: () {
                      // Implementasi aksi saat gambar game diklik
                      print('Game ${index + 1} clicked!');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3 - 16.0,
                      height: MediaQuery.of(context).size.width / 3 - 16.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            gameImages[index],
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 8.0), // Spasi antara gambar dan teks
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Teks "NEWS" di bawah gambar game
            Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  '**NEWS**',
                  style: TextStyle(
                    color: Colors.white, // Warna teks putih
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Kartu "NEWS" dengan lebar 5 dan drop shadow
            Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(5, (index) {
                  String newsImage = newsImages[index % newsImages.length]; // Siklus gambar berita yang berbeda
                  return GestureDetector(
                    onTap: () {
                      // Implementasi aksi saat kartu berita diklik
                      print('News ${index + 1} clicked!');
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              newsImage,
                              width: 200.0,
                              height: 150.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '',
                            // style: TextStyle(
                            //   fontSize: 20.0,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),

                          SizedBox(height: 8.0),
                          Text(
                            newsContents[index],
                            style: TextStyle(fontSize: 16.0),
                          ),
                          // Add any other content or widgets related to news
                        ],
                      ),
                    ),
                  );
                }),
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
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF4E2208), // Warna latar belakang BottomAppBar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman copyright
                  print('Copyright clicked!');
                },
                child: Text(
                  'Copyright',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman terms
                  print('Terms clicked!');
                },
                child: Text(
                  'Terms',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman privacy policy
                  print('Privacy Policy clicked!');
                },
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman cookie policy
                  print('Cookie Policy clicked!');
                },
                child: Text(
                  'Cookie Policy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
