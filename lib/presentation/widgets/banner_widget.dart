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
            // Đảm bảo rằng hình ảnh chiếm hết không gian thẻ
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height *
                    0.27, // Giới hạn chiều cao
                maxWidth:
                    MediaQuery.of(context).size.width, // Giới hạn chiều rộng
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl.isNotEmpty
                      ? imageUrl
                      : 'https://via.placeholder.com/150',
                  fit: BoxFit.cover, // Đảm bảo hình ảnh phủ kín không gian
                  height: double
                      .infinity, // Đảm bảo hình ảnh chiếm toàn bộ chiều cao của ConstrainedBox
                  width: double
                      .infinity, // Đảm bảo hình ảnh chiếm toàn bộ chiều rộng của ConstrainedBox
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
