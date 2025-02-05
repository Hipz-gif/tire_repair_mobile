import 'package:tire_repair_mobile/data/datasources/banner_remote_data_source.dart';
import 'package:tire_repair_mobile/data/models/banner_model.dart';
import 'package:tire_repair_mobile/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource remoteDataSource;

  BannerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<BannerModel>> fetchBanners() async {
    return await remoteDataSource.fetchBanners();
  }
}
