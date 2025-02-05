import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/domain/repositories/spare_part_repository.dart';
import 'package:tire_repair_mobile/presentation/blocs/spare_part_bloc.dart';
import 'package:tire_repair_mobile/presentation/widgets/spare_part_card.dart';
import 'package:tire_repair_mobile/presentation/widgets/search_bar_widget.dart';
import 'package:tire_repair_mobile/resources/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SparePartBloc(
          sparePartRepository:
              RepositoryProvider.of<SparePartRepository>(context))
        ..add(FetchSpareParts()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Trang Chủ',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: ColorsGlobal.themeApp,
        ),
        backgroundColor: ColorsGlobal.themeApp, // Đặt màu nền
        body: BlocListener<SparePartBloc, SparePartState>(
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
                return Center(child: CircularProgressIndicator());
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
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              return Center(child: Text('Không có dữ liệu.'));
            },
          ),
        ),
      ),
    );
  }
}
