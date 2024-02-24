import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:untitled1/data/secure_storage.dart';
import 'package:untitled1/utility/hive_models/pet_type_info_model.dart';
import 'package:untitled1/manager/api_link_manager.dart';
import 'package:untitled1/services/pet_type_info_management/pet_type_info_management_service_interface.dart';
import 'package:http/http.dart' as http;

class PetTypeInfoManagementService
    implements PetTypeInfoManagementServiceInterface {
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
  Future<void> deletePetTypeInfo({required String petTypeInfoID}) async {
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http.delete(
        Uri.parse(ApiLinkManager.deletePetTypeInfo() + petTypeInfoID),
        headers: <String, String>{
          // 'accept': 'text/plain',
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception(
            'Failed to delete Pet type info. Please try again later.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout. Please try again later.');
    }
  }
}
