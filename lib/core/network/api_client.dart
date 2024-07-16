import 'dart:convert';
import 'package:http/http.dart' as http;

class APIClient {
  static const baseUrl = 'http://localhost:3000';
  final http.Client httpClient;

  APIClient({required this.httpClient});

  Future<dynamic> get(String endpoint) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<dynamic> post(String endpoint, {required dynamic data}) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data to API');
    }
  }
}
