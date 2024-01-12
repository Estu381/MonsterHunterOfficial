import 'package:flutter/material.dart';

class OurGamesPage extends StatefulWidget {
  @override
  _OurGamesPageState createState() => _OurGamesPageState();
}

class _OurGamesPageState extends State<OurGamesPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Games'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: gameImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print('Game ${index + 1} clicked!');
                // Tambahkan logika navigasi atau aksi lainnya jika diperlukan
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
                    SizedBox(height: 8.0),
                    // Tambahkan teks atau widget lainnya jika diperlukan
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
