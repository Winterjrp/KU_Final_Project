import 'package:untitled1/models/user_info_model.dart';

class TemplateViewModel {
  // late AddPetInfoServiceInterface services;
  late List<UserInfoModel> userInfoListData;
  TemplateViewModel() {
    // services = AddPetProfileMockService();
  }

  Future<void> getUseInfoList() async {
    // await services.postHomeData(petProfile: petInfo);
  }
}
