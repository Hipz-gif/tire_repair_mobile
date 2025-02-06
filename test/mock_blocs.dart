import 'package:bloc_test/bloc_test.dart';
import 'package:tire_repair_mobile/presentation/blocs/auth_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/spare_part_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/banner_bloc.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockSparePartBloc extends MockBloc<SparePartEvent, SparePartState>
    implements SparePartBloc {}

class MockBannerBloc extends MockBloc<BannerEvent, BannerState>
    implements BannerBloc {}
