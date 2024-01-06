import 'package:untitled1/models/user_info_model.dart';

abstract class LoginServiceInterface {
  Future<UserInfoModel> login(
      {required String username, required String password});
}
