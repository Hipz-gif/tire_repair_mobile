import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tire_repair_mobile/core/error/auth_error.dart';
import 'package:tire_repair_mobile/core/utils/api_constants.dart';
import 'package:tire_repair_mobile/data/datasources/spare_part_remote_data_source.dart';
import 'package:tire_repair_mobile/data/models/spare_part_model.dart';

class SparePartRemoteDataSourceImpl implements SparePartRemoteDataSource {
  @override
  Future<List<SparePartModel>> fetchSpareParts() async {
    final url = Uri.parse('${ApiConstants.baseUrlSpareParts}/spare-parts');

    try {
      print('Sending request to $url');
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = jsonDecode(response.body);
          print('API Response: $data');
          List<SparePartModel> spareParts = data
              .map((jsonItem) => SparePartModel.fromJson(jsonItem))
              .toList();
          return spareParts;
        } catch (e) {
          print('Error parsing response: $e');
          throw Exception('Error parsing response');
        }
      } else {
        print('API Error: ${response.statusCode}');
        final errorMessage =
            jsonDecode(response.body)['message'] ?? SparePartError.fetchError;
        throw Exception('Failed to fetch spare parts: $errorMessage');
      }
    } catch (e) {
      print('Error in fetchSpareParts: $e'); // In ra lỗi chi tiết
      throw Exception('${SparePartError.networkError}: $e');
    }
  }
}
