import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/error/exceptions.dart';

abstract class NetworkService {
  Future<Map<String, dynamic>> get(String url);
}

class NetworkServiceImpl implements NetworkService {
  final http.Client client;

  NetworkServiceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ServerException(
          message: 'Server error: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      } else {
        throw NetworkException(message: 'Network error: ${e.toString()}');
      }
    }
  }
}
