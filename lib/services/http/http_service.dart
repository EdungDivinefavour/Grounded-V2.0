import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  HttpService._();
  static final HttpService _instance = HttpService._();
  static HttpService get instance => _instance;

  Future<dynamic> post(
    String url, {
    required Map<String, String> headers,
    required Map<String, dynamic> body,
  }) {
    return http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  }
}
