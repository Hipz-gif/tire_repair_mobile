import 'package:get_it/get_it.dart';
import 'package:tire_repair_mobile/data/datasources/auth_remote_data_source.dart';
import 'package:tire_repair_mobile/data/datasources/auth_remote_data_source_impl.dart';
import 'package:tire_repair_mobile/data/datasources/banner_remote_data_source.dart';
import 'package:tire_repair_mobile/data/datasources/banner_remote_data_source_impl.dart';
import 'package:tire_repair_mobile/data/datasources/spare_parts_remote_data_source_impl.dart';
import 'package:tire_repair_mobile/data/repositories/auth_repository_impl.dart';
import 'package:tire_repair_mobile/data/repositories/banner_repository_impl.dart';
import 'package:tire_repair_mobile/domain/repositories/auth_repository.dart';
import 'package:tire_repair_mobile/data/datasources/spare_part_remote_data_source.dart';
import 'package:tire_repair_mobile/data/repositories/spare_part_repository_impl.dart';
import 'package:tire_repair_mobile/domain/repositories/banner_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/spare_part_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Đăng ký AuthRemoteDataSource
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Đăng ký AuthRepository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: locator<AuthRemoteDataSource>()),
  );

  // Đăng ký SparePartRemoteDataSource
  locator.registerLazySingleton<SparePartRemoteDataSource>(
    () => SparePartRemoteDataSourceImpl(),
  );

  // Đăng ký SparePartRepository
  locator.registerLazySingleton<SparePartRepository>(
    () => SparePartRepositoryImpl(
        remoteDataSource: locator<SparePartRemoteDataSource>()),
  );
  // Đăng ký BannerRemoteDataSource
  locator.registerLazySingleton<BannerRemoteDataSource>(
    () => BannerRemoteDataSourceImpl(),
  );

  // Đăng ký BannerRepository
  locator.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(
        remoteDataSource: locator<BannerRemoteDataSource>()),
  );
}
