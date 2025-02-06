import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tire_repair_mobile/main.dart'; // Import main.dart để test UI
import 'package:tire_repair_mobile/di/service_locator.dart';
import 'package:tire_repair_mobile/domain/repositories/auth_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/spare_part_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/banner_repository.dart';
import 'package:tire_repair_mobile/presentation/blocs/auth_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/banner_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/spare_part_bloc.dart';
import 'package:tire_repair_mobile/presentation/pages/splash_screen.dart';
import 'mock_repositories.dart';
import 'mock_blocs.dart';

void main() {
  setUp(() {
    setupLocator(); // Thiết lập mock trước khi chạy test
  });

  testWidgets('SplashScreen is displayed on app launch',
      (WidgetTester tester) async {
    // Mock các repository
    final mockAuthRepository = MockAuthRepository();
    final mockSparePartRepository = MockSparePartRepository();
    final mockBannerRepository = MockBannerRepository();

    // Mock các bloc
    final mockAuthBloc = MockAuthBloc();
    final mockSparePartBloc = MockSparePartBloc();
    final mockBannerBloc = MockBannerBloc();

    // Thiết lập môi trường với các bloc và repository mock
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (context) => mockAuthRepository,
          ),
          RepositoryProvider<SparePartRepository>(
            create: (context) => mockSparePartRepository,
          ),
          RepositoryProvider<BannerRepository>(
            create: (context) => mockBannerRepository,
          ),
          BlocProvider<AuthBloc>(
            create: (context) => mockAuthBloc,
          ),
          BlocProvider<SparePartBloc>(
            create: (context) => mockSparePartBloc,
          ),
          BlocProvider<BannerBloc>(
            create: (context) => mockBannerBloc..add(FetchBanners()),
          ),
        ],
        child: const MyApp(),
      ),
    );

    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
