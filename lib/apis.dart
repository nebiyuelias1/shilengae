import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shilengae_demo/models.dart';

class Apis {
  final String baseUrl =
      'http://ec2-15-185-115-103.me-south-1.compute.amazonaws.com:8001';

  Future<int> getApiVersion() async {
    final uri = Uri.parse('$baseUrl/api/app-version/');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['category_version'];
    }

    throw Exception('Failed to load version.');
  }

  Future<List<Category>> fetchCategoriesList() async {
    final uri =
        Uri.parse('$baseUrl/forms/category/level-with-subcategories-v2/');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return (json['results'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList();
    }

    throw Exception('Failed to load categories.');
  }
}
