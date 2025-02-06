import 'package:flutter/material.dart';

import 'package:tire_repair_mobile/data/models/spare_part_model.dart';

class SearchResultWidget extends StatelessWidget {
  final List<SparePartModel> spareParts;
  final ValueChanged<SparePartModel> onSelect;

  const SearchResultWidget({
    super.key,
    required this.spareParts,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: spareParts.length,
      itemBuilder: (context, index) {
        final sparePart = spareParts[index];
        return ListTile(
          onTap: () => onSelect(sparePart),
          title: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              sparePart.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          subtitle: Text(sparePart.partName),
          leading: Image.network(
            sparePart.imageUrl,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
