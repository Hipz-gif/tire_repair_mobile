import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const BannerWidget({
    super.key,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Image.network(imageUrl, fit: BoxFit.cover),
            ListTile(
              title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(content),
            ),
          ],
        ),
      ),
    );
  }
}
