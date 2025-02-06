import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/domain/repositories/banner_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/spare_part_repository.dart';
import 'package:tire_repair_mobile/presentation/blocs/spare_part_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/banner_bloc.dart';
import 'package:tire_repair_mobile/presentation/widgets/spare_part_list.dart';
import 'package:tire_repair_mobile/presentation/widgets/app_bar_widget.dart';
import 'package:tire_repair_mobile/presentation/widgets/drawer_widget.dart';
import 'package:tire_repair_mobile/presentation/widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SparePartBloc(
        sparePartRepository:
            RepositoryProvider.of<SparePartRepository>(context),
      )..add(FetchSpareParts()),
      child: Scaffold(
        appBar: const AppBarWidget(),
        drawer: const DrawerWidget(),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<BannerBloc>(
              create: (context) => BannerBloc(
                bannerRepository:
                    RepositoryProvider.of<BannerRepository>(context),
              )..add(FetchBanners()),
            ),
          ],
          child: Column(
            children: [
              // Tìm kiếm phụ tùng
              SearchBarWidget(
                onSearch: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
                spareParts: const [],
                onSelect: (sparePart) {
                  // Hành động khi chọn một sparePart
                },
              ),
              // Danh sách phụ tùng
              Expanded(
                child: BlocBuilder<SparePartBloc, SparePartState>(
                  builder: (context, state) {
                    if (state is SparePartLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SparePartLoaded) {
                      // Lọc phụ tùng theo từ khóa tìm kiếm
                      state.spareParts
                          .where((part) => part.partName
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                          .toList();

                      return const SparePartList();
                    } else if (state is SparePartError) {
                      return Center(child: Text('Lỗi: ${state.message}'));
                    }
                    return const Center(child: Text('Không có dữ liệu.'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
