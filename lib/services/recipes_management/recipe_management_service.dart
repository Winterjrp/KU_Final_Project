import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/services/recipes_management/recipes_management%20_service_interface.dart';

class IngredientManagementService implements RecipesManagementServiceInterface {
  @override
  Future<List<RecipeModel>> getRecipeListData() async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/albums'),
        headers: <String, String>{
          // 'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer token',
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return json
            .decode(response.body)
            .map((json) => RecipeModel.fromJson(json))
            .toList();
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to load Data.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout.');
    }
  }

  @override
  Future<void> addRecipeData({required RecipeModel recipesData}) async {
    try {
      final response = await http
          .post(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
              headers: <String, String>{
                // 'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer token',
              },
              body: recipesData.toJson())
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to add Recipe.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout.');
    }
  }

  @override
  Future<void> editRecipeData({required RecipeModel recipeData}) async {
    try {
      final response = await http
          .post(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
              headers: <String, String>{
                // 'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer token',
              },
              body: recipeData.toJson())
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to edit Recipe.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout.');
    }
  }

  @override
  Future<void> deleteRecipeData({required String recipeId}) async {
    try {
      final response = await http
          .post(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
              headers: <String, String>{
                // 'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer token',
              },
              body: '{"ingredientId": $recipeId}')
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to delete Recipe.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout.');
    }
  }
}
