import 'dart:async';
import 'dart:io';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/services/update_ingredients_services/update_ingredient_service_interface.dart';

class UpdateIngredientService implements UpdateIngredientServiceInterface {
  @override
  Future<void> addIngredientData(
      {required IngredientModel ingredientData}) async {
    try {
      final response = await http
          .post(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
              headers: <String, String>{
                // 'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer token',
              },
              body: ingredientData.toJson())
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to add Ingredient.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout.');
    }
  }

  @override
  Future<void> editIngredientData(
      {required IngredientModel ingredientData}) async {
    try {
      final response = await http
          .post(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
              headers: <String, String>{
                // 'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer token',
              },
              body: ingredientData.toJson())
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to edit Ingredient.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout.');
    }
  }
}
