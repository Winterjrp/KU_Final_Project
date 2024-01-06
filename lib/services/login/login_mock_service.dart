import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/services/login/login_service_interface.dart';

class LoginMockService implements LoginServiceInterface {
  @override
  Future<UserInfoModel> login(
      {required String username, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    http.Response mockResponse = http.Response(
        '''
  {
    "username": "คุณนีน่า",
    "userID": "12345678",
    "userRole": {
      "isUserManagementAdmin": true,
      "isPetFoodManagementAdmin": true
    }
  }
  ''',
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
    UserInfoModel userInfoData;
    if (mockResponse.statusCode == 200) {
      // print(jsonDecode(mockResponse.body));
      userInfoData = UserInfoModel.fromJson(json.decode(mockResponse.body));
    } else if (mockResponse.statusCode == 400) {
      throw Exception(
          "Username and password cannot be empty. Please provide valid credentials.");
    } else if (mockResponse.statusCode == 500) {
      throw Exception('Internal Server Error. Please try again later.');
    } else {
      throw Exception('Failed to login.');
    }
    return userInfoData;
  }
}
