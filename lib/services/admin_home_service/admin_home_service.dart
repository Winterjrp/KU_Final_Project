import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:untitled1/data/secure_stroage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/manager/api_link_manager.dart';
import 'package:untitled1/modules/admin/admin_add_pet_info/admin_home_model.dart';
import 'package:untitled1/services/admin_home_service/admin_home_service_interface.dart';

class AdminHomeService implements AdminHomeServiceInterface {
  @override
  Future<AdminHomeModel> getAdminHomeData() async {
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http.get(
        Uri.parse(ApiLinkManager.getAdminHomeData()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return AdminHomeModel.fromJson(json.decode(response.body));
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
