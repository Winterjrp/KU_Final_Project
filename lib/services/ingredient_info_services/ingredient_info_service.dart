import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:untitled1/services/ingredient_info_services/ingredient_info_service_interface.dart';

class IngredientInfoService implements IngredientInfoServiceInterface {
  @override
  Future<void> deleteIngredientInfo({required String ingredientId}) async {
    try {
      final response = await http
          .post(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
              headers: <String, String>{
                // 'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer token',
              },
              body: '{"ingredientId": $ingredientId}')
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to delete Ingredient.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout.');
    }
  }
}
