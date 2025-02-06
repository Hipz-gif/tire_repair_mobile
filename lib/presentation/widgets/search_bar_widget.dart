import 'package:flutter/material.dart';
import 'package:tire_repair_mobile/data/models/spare_part_model.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onSearch;
  final List<SparePartModel> spareParts;
  final Function(SparePartModel) onSelect;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    required this.spareParts,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          labelText: 'Tìm kiếm phụ tùng',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Thực hiện hành động tìm kiếm
            },
          ),
        ),
      ),
    );
  }
}
