import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/banner_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/spare_part_bloc.dart';
import 'package:tire_repair_mobile/presentation/widgets/spare_part_card.dart';
import 'package:tire_repair_mobile/presentation/widgets/banner_widget.dart';

import 'dart:async';

class SparePartList extends StatefulWidget {
  const SparePartList({super.key});

  @override
  SparePartListState createState() => SparePartListState();
}

class SparePartListState extends State<SparePartList> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  int _totalBanners = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Tạo timer để chuyển trang tự động sau mỗi 3 giây
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _totalBanners - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.jumpToPage(0); // Quay lại trang đầu sau khi hết
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SparePartBloc, SparePartState>(
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
            return Column(
              children: [
                BlocBuilder<BannerBloc, BannerState>(
                  builder: (context, bannerState) {
                    if (bannerState is BannerLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (bannerState is BannerLoaded) {
                      final banners = bannerState.banners;
                      _totalBanners =
                          banners.length; // Cập nhật số lượng banner
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: banners.length,
                          itemBuilder: (context, index) {
                            final banner = banners[index];
                            return BannerWidget(
                              title: banner.title,
                              content: banner.content,
                              imageUrl: banner.adUrl,
                            );
                          },
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                        ),
                      );
                    } else if (bannerState is BannerError) {
                      return Center(child: Text('Lỗi: ${bannerState.message}'));
                    }
                    return const SizedBox();
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
                    itemCount: state.spareParts.length,
                    itemBuilder: (context, index) {
                      final sparePart = state.spareParts[index];
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
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Hủy timer khi không còn sử dụng
    _pageController.dispose();
    super.dispose();
  }
}
