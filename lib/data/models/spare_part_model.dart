import 'package:intl/intl.dart';

class SparePartModel {
  final int partId;
  final String partName;
  final double partPrice;
  final int stockQuantity;
  final DateTime createdAt;
  final String imageUrl;

  SparePartModel({
    required this.partId,
    required this.partName,
    required this.partPrice,
    required this.stockQuantity,
    required this.createdAt,
    required this.imageUrl,
  });

  // Hàm factory để chuyển đổi từ JSON sang object
  factory SparePartModel.fromJson(Map<String, dynamic> json) {
    return SparePartModel(
      partId: json['part_id'],
      partName: json['part_name'],
      partPrice: json['part_price'].toDouble(),
      stockQuantity: json['stock_quantity'],
      createdAt: DateTime.parse(json['created_at']),
      imageUrl: json['image'],
    );
  }

  // Hàm để chuyển đối tượng thành chuỗi JSON (nếu cần thiết)
  Map<String, dynamic> toJson() {
    return {
      'part_id': partId,
      'part_name': partName,
      'part_price': partPrice,
      'stock_quantity': stockQuantity,
      'created_at':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(createdAt),
      'image': imageUrl,
    };
  }
}
