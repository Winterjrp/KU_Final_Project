import 'package:untitled1/modules/normal/login/user_info_model.dart';
import 'package:untitled1/modules/admin/admin_add_pet_info/models/admin_home_model.dart';
import 'package:untitled1/services/admin_home_service/admin_home_service.dart';
import 'package:untitled1/services/admin_home_service/admin_home_service_interface.dart';
import 'package:untitled1/services/shared_preferences_services/user_info.dart';

class AdminHomeViewModel {
  late AdminHomeServiceInterface service;
  late Future<AdminHomeModel> adminHomeDataFetch;
  late AdminHomeModel adminHomeData;
  late Future<UserInfoModel?> retrievedUserInfoData;
  late UserInfoModel? retrievedUserInfo;

  AdminHomeViewModel() {
    service = AdminHomeService();
  }

  Future<void> getData() async {
    try {
      adminHomeDataFetch = service.getAdminHomeData();
      adminHomeData = await adminHomeDataFetch;
      retrievedUserInfoData = SharedPreferencesService.getUserInfo();
      retrievedUserInfo = await retrievedUserInfoData;
    } catch (e) {
      rethrow;
    }
  }
}
