import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  AnimatedBackground({required this.child});

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'URL_GAMBAR_ANIMASI', // Ganti dengan URL gambar animasi Anda
      placeholder: (context, url) => Container(color: Colors.transparent), // Placeholder sementara
      errorWidget: (context, url, error) => Icon(Icons.error), // Widget yang ditampilkan jika terjadi kesalahan
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
