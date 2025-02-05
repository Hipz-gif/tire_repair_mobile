import 'package:tire_repair_mobile/data/models/spare_part_model.dart';

abstract class SparePartRepository {
  Future<List<SparePartModel>> fetchSpareParts();
}
