import 'package:mockito/mockito.dart';
import 'package:tire_repair_mobile/domain/repositories/auth_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/spare_part_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/banner_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSparePartRepository extends Mock implements SparePartRepository {}

class MockBannerRepository extends Mock implements BannerRepository {}
