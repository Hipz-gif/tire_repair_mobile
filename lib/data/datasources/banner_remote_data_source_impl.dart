import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tire_repair_mobile/data/datasources/banner_remote_data_source.dart';
import 'package:tire_repair_mobile/data/models/banner_model.dart';
import 'package:tire_repair_mobile/core/utils/api_constants.dart';

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  @override
  Future<List<BannerModel>> fetchBanners() async {
    final url = Uri.parse('${ApiConstants.baseUrlSpareParts}/advertisements');

    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((jsonItem) => BannerModel.fromJson(jsonItem)).toList();
      } else {
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      throw Exception('Failed to load banners: $e');
    }
  }
}
