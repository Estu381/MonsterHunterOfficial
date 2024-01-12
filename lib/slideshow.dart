import 'package:flutter/material.dart';

class SlideshowPage extends StatelessWidget {
  final List<String> slideImages;

  SlideshowPage({required this.slideImages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slideshow Page'),
      ),
      body: ListView.builder(
        itemCount: slideImages.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              slideImages[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
