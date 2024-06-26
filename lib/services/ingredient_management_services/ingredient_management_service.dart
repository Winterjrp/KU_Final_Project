import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:untitled1/data/secure_stroage.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/manager/api_link_manager.dart';
import 'package:untitled1/services/ingredient_management_services/ingredient_management_service_interface.dart';

class IngredientManagementService
    implements IngredientManagementServiceInterface {
  @override
  Future<List<IngredientModel>> getIngredientListData() async {
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http.get(
        Uri.parse(ApiLinkManager.getAllIngredient()),
        headers: <String, String>{
          // 'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        List<IngredientModel> data =
            (json.decode(response.body) as List<dynamic>)
                .map((json) => IngredientModel.fromJson(json))
                .toList();

        return data;
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
  Future<void> addIngredientData(
      {required IngredientModel ingredientData}) async {
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http
          .post(Uri.parse(ApiLinkManager.addIngredientInfo()),
              headers: <String, String>{
                // 'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
              body: json.encode(ingredientData.toJson()))
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
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http
          .put(
            Uri.parse(ApiLinkManager.editIngredientInfo()),
            headers: <String, String>{
              // 'Accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8',
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
            body: json.encode(
              ingredientData.toJson(),
            ),
          )
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

  @override
  Future<void> deleteIngredientInfo({required String ingredientId}) async {
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http.delete(
        Uri.parse(ApiLinkManager.deleteIngredientInfo() + ingredientId),
        headers: <String, String>{
          // 'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));
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
