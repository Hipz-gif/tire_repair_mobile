import 'package:flutter/material.dart';
import 'package:tire_repair_mobile/data/models/spare_part_model.dart';
import 'package:tire_repair_mobile/resources/color.dart';

class SparePartDetailPage extends StatelessWidget {
  final SparePartModel sparePart;

  const SparePartDetailPage({super.key, required this.sparePart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sparePart.partName),
        backgroundColor: ColorsGlobal.themeApp,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                sparePart.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            sparePart.partName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Giá: ${sparePart.partPrice.toStringAsFixed(2)} VNĐ',
            style: const TextStyle(fontSize: 18, color: Colors.green),
          ),
          const SizedBox(height: 8),
          Text(
            'Số lượng: ${sparePart.stockQuantity}',
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
