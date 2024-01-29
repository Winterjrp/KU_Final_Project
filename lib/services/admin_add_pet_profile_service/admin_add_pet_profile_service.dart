import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:untitled1/data/secure_stroage.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/manager/api_link_manager.dart';
import 'package:untitled1/services/admin_add_pet_profile_service/admin_add_pet_profile_service_interface.dart';

class AdminAddPetProfileService implements AdminAddPetProfileServiceInterface {
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
}
