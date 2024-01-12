import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Page'),
      ),
      body: ListView.builder(
        itemCount: newsHeadlines.length,
        itemBuilder: (context, index) {
          String newsImage = newsImages[index % newsImages.length];
          return GestureDetector(
            onTap: () {
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
                    offset: Offset(0, 3),
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
                    newsHeadlines[index],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    newsContents[index],
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
