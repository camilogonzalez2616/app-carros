import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('https://carros-electricos.wiremockapi.cloud/auth');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['token'];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
