import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mhofficial/admin_page.dart';
import 'about_page.dart'; // Import AboutPage
import 'contact_page.dart'; // Import ContactPage


class edit extends StatefulWidget {
  @override
  _editState createState() => _editState();
}

class _editState extends State<edit> {
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

  final List<String> editableNewsContents = [
    'New design coming to official Capcom apparel on Amazon!',
    'Vote for your favorite monster in the Hunters choice (Top Monster)!',
    'Monster Hunter Rise: Sunbreak All Title Update Out Now!',
    'MONSTER HUNTER RISE (Xbox Series X|S/Xbox One/Windows/PS5/PS4) ',
    'Monster Hunter Rise: Sunbreak Roadmap Free Title Updates',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Image.asset(
                                  newsImage,
                                  width: 200.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Tombol Edit
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Open a dialog for editing the news content
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String editedContent = editableNewsContents[index];
                                      return AlertDialog(
                                        title: Text('Edit News'),
                                        content: TextField(
                                          onChanged: (value) {
                                            editedContent = value;
                                          },
                                          controller: TextEditingController(text: editableNewsContents[index]),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Save the edited content
                                              setState(() {
                                                editableNewsContents[index] = editedContent;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Save'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Close the dialog without saving changes
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            editableNewsContents[index],
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