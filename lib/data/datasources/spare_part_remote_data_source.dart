import 'package:tire_repair_mobile/data/models/spare_part_model.dart';

abstract class SparePartRemoteDataSource {
  Future<List<SparePartModel>> fetchSpareParts();
}
