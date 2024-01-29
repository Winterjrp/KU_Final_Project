import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:untitled1/data/secure_stroage.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/manager/api_link_manager.dart';
import 'package:untitled1/modules/admin/update_pet_type_info/model/edited_pet_type_model.dart';
import 'package:untitled1/services/add_pet_type_info_services/update_pet_type_info_service_interface.dart';
import 'package:http/http.dart' as http;

class UpdatePetTypeInfoService implements UpdatePetTypeInfoServiceInterface {
  @override
  Future<void> addPetTypeInfoData(
      {required PetTypeInfoModel petTypeInfoData}) async {
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http
          .post(
            Uri.parse(ApiLinkManager.addPetTypeInfo()),
            headers: <String, String>{
              // 'Accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8',
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
            body: json.encode(petTypeInfoData.toJson()),
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to add Pet type info. Please try again later.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout. Please try again later.');
    }
  }

  @override
  Future<void> editPetTypeInfoData(
      {required EditedPetTypeModel petTypeInfoData}) async {
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http
          .put(Uri.parse(ApiLinkManager.editPetTypeInfo()),
              headers: <String, String>{
                // 'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
              body: json.encode(petTypeInfoData.toJson()))
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception(
            'Failed to edit Pet type info. Please try again later.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout. Please try again later.');
    }
  }
}
