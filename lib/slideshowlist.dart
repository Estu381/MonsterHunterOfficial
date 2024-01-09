import 'package:flutter/material.dart';

class SlideshowList extends StatelessWidget {
  final List<String> slideImages;
  final Function(int) onDelete;

  const SlideshowList({Key? key, required this.slideImages, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: slideImages.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(slideImages[index]),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Call the onDelete function with the index to delete the item
              onDelete(index);
            },
          ),
        );
      },
    );
  }
}
