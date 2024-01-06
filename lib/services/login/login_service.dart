import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/services/login/login_service_interface.dart';

class LoginService implements LoginServiceInterface {
  @override
  Future<UserInfoModel> login(
      {required String username, required String password}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    try {
      final response = await http
          .post(
            Uri.parse('https://03f5-1-47-146-51.ngrok-free.app/api/auth/login'),
            headers: headers,
            body: json.encode({
              "firstname": "Test",
              "lastname": "User",
              "age": 22,
              "username": "",
              "password": "1234"
            }),
          )
          .timeout(
            const Duration(seconds: 30),
          );
      if (response.statusCode == 200) {
        return UserInfoModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 500) {
        // return response.statusCode;
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to Login, please try again later.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout');
    }
  }
}
