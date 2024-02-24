import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/data/secure_storage.dart';
import 'package:untitled1/manager/api_link_manager.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/services/login/login_service_interface.dart';
import 'package:untitled1/services/shared_preferences_services/user_info.dart';

class LoginService implements LoginServiceInterface {
  @override
  Future<void> login(
      {required String username, required String password}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http
          .post(
            Uri.parse(ApiLinkManager.login()),
            headers: headers,
            body: json.encode({"username": "Admin", "password": "Hello1234"}),
          )
          .timeout(
            const Duration(seconds: 30),
          );
      UserInfoModel userInfoData;
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        userInfoData = UserInfoModel.fromJson(jsonData);
        // print(jsonData['accessToken']);
        await SecureStorage()
            .writeSecureData(key: "token", value: jsonData['accessToken']);
        // print(jsonData['accessToken']);
        SharedPreferencesService.saveUserInfo(userInfoData);
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to Login, please try again later.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout');
    }
  }
}
