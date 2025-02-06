import 'package:tire_repair_mobile/data/datasources/spare_part_remote_data_source.dart';
import 'package:tire_repair_mobile/data/models/spare_part_model.dart';

import 'package:tire_repair_mobile/domain/repositories/spare_part_repository.dart';

class SparePartRepositoryImpl implements SparePartRepository {
  @override
  Future<List<SparePartModel>> fetchSpareParts() async {
    return await getSpareParts();
  }

  final SparePartRemoteDataSource remoteDataSource;

  SparePartRepositoryImpl({required this.remoteDataSource});

  Future<List<SparePartModel>> getSpareParts() async {
    try {
      final spareParts = await remoteDataSource.fetchSpareParts();
      return spareParts
          .map((sparePartModel) => SparePartModel(
                partId: sparePartModel.partId,
                partName: sparePartModel.partName,
                partPrice: sparePartModel.partPrice,
                stockQuantity: sparePartModel.stockQuantity,
                createdAt: sparePartModel.createdAt,
                imageUrl: sparePartModel.imageUrl,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch spare parts: $e');
    }
  }
}
