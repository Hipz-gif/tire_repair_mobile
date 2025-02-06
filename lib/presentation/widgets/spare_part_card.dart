import 'package:flutter/material.dart';
import 'package:tire_repair_mobile/data/models/spare_part_model.dart';
import 'package:tire_repair_mobile/presentation/pages/spare_part_detail_page.dart';

class SparePartCard extends StatelessWidget {
  final SparePartModel sparePart;

  const SparePartCard({super.key, required this.sparePart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Điều hướng đến trang chi tiết khi nhấn vào card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SparePartDetailPage(sparePart: sparePart),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  sparePart.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                sparePart.partName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
