import '../models/token_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Token> fetchToken(String channel, String code) async {
  final response = await http.get(
      'https://vis-dev-kokkehjelp.azurewebsites.net/api/GenerateToken?channel=${channel}&code=${code}');
  if (response.statusCode == 200) {
    return Token.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load token');
  }
}
