import 'package:untitled1/models/user_info_model.dart';

class LoginViewModel {
  // late AddPetInfoServiceInterface services;
  late UserInfoModel userInfoData;

  LoginViewModel() {
    // services = AddPetProfileMockService();
  }

  Future<void> getUserInfo(
      {required String username, required String password}) async {
    userInfoData = UserInfoModel(
        username: "คุณนีน่า",
        userID: "12345678",
        userRole: UserRoleModel(
            isUserManagementAdmin: true, isPetFoodManagementAdmin: true));
    // await services.postHomeData(petProfile: petInfo);
  }
}
