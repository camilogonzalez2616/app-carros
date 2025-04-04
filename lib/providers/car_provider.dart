import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/car.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];

  List<Car> get cars => _cars;

  Future<void> fetchCars(String token) async {
    final url = Uri.parse('https://carros-electricos.wiremockapi.cloud/carros');

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json", "Authentication": token},
    );

    if (response.statusCode == 200) {
      final List<dynamic> carData = jsonDecode(response.body);
      _cars = carData.map((json) => Car.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
