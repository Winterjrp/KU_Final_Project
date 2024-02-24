import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:untitled1/data/secure_storage.dart';
import 'package:untitled1/utility/hive_models/ingredient_model.dart';
import 'package:untitled1/utility/hive_models/pet_type_info_model.dart';
import 'package:untitled1/utility/hive_models/recipes_model.dart';
import 'package:untitled1/manager/api_link_manager.dart';
import 'package:untitled1/services/update_recipes_services/update_recipes_service_interface.dart';

class AddRecipesService implements UpdateRecipesServiceInterface {
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
  Future<List<PetTypeInfoModel>> getPetTypeInfoData() async {
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http.get(
        Uri.parse(ApiLinkManager.getAllPetTypeInfo()),
        headers: <String, String>{
          // 'accept': 'text/plain',
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        List<PetTypeInfoModel> data =
            (json.decode(response.body) as List<dynamic>)
                .map((json) => PetTypeInfoModel.fromJson(json))
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
  Future<void> addRecipeData({required RecipeModel recipesData}) async {
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http
          .post(Uri.parse(ApiLinkManager.addRecipeInfo()),
              headers: <String, String>{
                // 'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
              body: json.encode(recipesData.toJson()))
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

  // @override
  // Future<void> editRecipeData({required RecipeModel recipesData}) async {
  //   String token = await SecureStorage().readSecureData(key: "token");
  //   try {
  //     final response = await http
  //         .put(Uri.parse(ApiLinkManager.editRecipeInfo()),
  //             headers: <String, String>{
  //               // 'Accept': 'application/json',
  //               'Content-Type': 'application/json; charset=UTF-8',
  //               HttpHeaders.authorizationHeader: 'Bearer $token',
  //             },
  //             body: json.encode(recipesData.toJson()))
  //         .timeout(const Duration(seconds: 30));
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //     } else if (response.statusCode == 500) {
  //       throw Exception('Internal Server Error. Please try again later.');
  //     } else {
  //       throw Exception('Failed to edit Recipe. Please try again later.');
  //     }
  //   } on TimeoutException catch (_) {
  //     throw Exception('Connection timeout. Please try again later.');
  //   }
  // }
}
