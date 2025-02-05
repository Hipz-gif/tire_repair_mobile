import 'package:tire_repair_mobile/data/models/banner_model.dart';

abstract class BannerRemoteDataSource {
  Future<List<BannerModel>> fetchBanners();
}
