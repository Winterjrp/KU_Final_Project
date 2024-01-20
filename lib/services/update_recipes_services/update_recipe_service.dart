import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/services/update_recipes_services/update_recipes_service_interface.dart';

class AddRecipesService implements UpdateRecipesServiceInterface {
  @override
  Future<List<IngredientModel>> getIngredientListData() async {
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
            .map((json) => IngredientModel.fromJson(json))
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
  Future<List<PetTypeInfoModel>> getPetTypeInfoData() async {
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
            .map((json) => PetTypeInfoModel.fromJson(json))
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
        throw Exception('Failed to add Recipe. Please try again later.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout. Please try again later.');
    }
  }

  @override
  Future<void> editRecipeData({required RecipeModel recipesData}) async {
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
        throw Exception('Failed to edit Recipe. Please try again later.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout. Please try again later.');
    }
  }
}
