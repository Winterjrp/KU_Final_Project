import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/services/login/login_mock_service.dart';
import 'package:untitled1/services/login/login_service_interface.dart';
import 'package:untitled1/services/shared_preferences_services/user_info.dart';

class LoginViewModel {
  late LoginServiceInterface services;
  late UserInfoModel userInfoData;

  LoginViewModel() {
    services = LoginMockService();
  }

  Future<UserInfoModel> login(
      {required String username, required String password}) async {
    try {
      userInfoData =
          await services.login(username: username, password: password);
      SharedPreferencesService.saveUserInfo(userInfoData);
      return userInfoData;
    } catch (e) {
      rethrow;
    }
    // userInfoData = UserInfoModel(
    //     username: "คุณนีน่า",
    //     userID: "12345678",
    //     userRole: UserRoleModel(
    //         isUserManagementAdmin: true, isPetFoodManagementAdmin: true));
  }

  // Future<void> getUserInfo(
  //     {required String username, required String password}) async {
  //   userInfoData = UserInfoModel(
  //       username: "คุณนีน่า",
  //       userID: "12345678",
  //       userRole: UserRoleModel(
  //           isUserManagementAdmin: true, isPetFoodManagementAdmin: true));
  //   // await services.postHomeData(petProfile: petInfo);
  // }
}
