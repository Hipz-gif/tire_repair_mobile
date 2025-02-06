import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/domain/repositories/banner_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/spare_part_repository.dart';
import 'package:tire_repair_mobile/presentation/blocs/spare_part_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/banner_bloc.dart'; // Import BannerBloc
import 'package:tire_repair_mobile/presentation/widgets/spare_part_card.dart';
import 'package:tire_repair_mobile/presentation/widgets/search_bar_widget.dart';
import 'package:tire_repair_mobile/resources/color.dart';
import 'package:tire_repair_mobile/presentation/widgets/banner_widget.dart'; // Import BannerWidget

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
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: MediaQuery.of(context).padding.bottom),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ),
          backgroundColor: ColorsGlobal.themeApp,
        ),
        backgroundColor: ColorsGlobal.themeApp, // Đặt màu nền
        body: MultiBlocProvider(
          providers: [
            BlocProvider<BannerBloc>(
              create: (context) => BannerBloc(
                bannerRepository:
                    RepositoryProvider.of<BannerRepository>(context),
              )..add(FetchBanners()), // Fetch banners when the page is loaded
            ),
          ],
          child: BlocListener<SparePartBloc, SparePartState>(
            listener: (context, state) {
              if (state is SparePartError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lỗi: ${state.message}')),
                );
              }
            },
            child: BlocBuilder<SparePartBloc, SparePartState>(
              builder: (context, state) {
                if (state is SparePartLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SparePartLoaded) {
                  final filteredParts = state.spareParts
                      .where((part) => part.partName
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                      .toList();

                  return Column(
                    children: [
                      SearchBarWidget(
                        onSearch: (query) {
                          setState(() {
                            searchQuery = query;
                          });
                        },
                      ),
                      // Hiển thị banner bằng BannerBloc
                      BlocBuilder<BannerBloc, BannerState>(
                        builder: (context, bannerState) {
                          if (bannerState is BannerLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (bannerState is BannerLoaded) {
                            final banners = bannerState.banners;
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: banners.length,
                                itemBuilder: (context, index) {
                                  final banner = banners[index];
                                  return BannerWidget(
                                    title: banner.title,
                                    content: banner.content,
                                    imageUrl: banner.adUrl,
                                  );
                                },
                              ),
                            );
                          } else if (bannerState is BannerError) {
                            return Center(
                                child: Text('Lỗi: ${bannerState.message}'));
                          }
                          return const SizedBox(); // Trả về một widget trống nếu không có dữ liệu
                        },
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: filteredParts.length,
                          itemBuilder: (context, index) {
                            final sparePart = filteredParts[index];
                            return SparePartCard(sparePart: sparePart);
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: Text('Không có dữ liệu.'));
              },
            ),
          ),
        ),
      ),
    );
  }
}
