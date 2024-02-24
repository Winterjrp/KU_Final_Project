import 'package:untitled1/utility/hive_models/pet_type_info_model.dart';
import 'package:untitled1/manager/service_manager.dart';
import 'package:untitled1/services/pet_type_info_management/pet_type_info_management_mock_service.dart';
import 'package:untitled1/services/pet_type_info_management/pet_type_info_management_service.dart';
import 'package:untitled1/services/pet_type_info_management/pet_type_info_management_service_interface.dart';

class PetTypeInfoManagementViewModel {
  late PetTypeInfoManagementServiceInterface services;
  late Future<List<PetTypeInfoModel>> petTypeInfoData;
  late List<PetTypeInfoModel> petTypeInfoList;
  late List<PetTypeInfoModel> filteredPetTypeInfoList;

  PetTypeInfoManagementViewModel() {
    services = ServiceManager.isRealService
        ? PetTypeInfoManagementService()
        : PetTypeInfoManagementMockService();
  }

  Future<void> getPetTypeInfoData() async {
    try {
      petTypeInfoData = services.getPetTypeInfoData();
      petTypeInfoList = await petTypeInfoData;
      filteredPetTypeInfoList = petTypeInfoList;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> onUserDeletePetTypeData({required String petTypeInfoID}) async {
    await services.deletePetTypeInfo(petTypeInfoID: petTypeInfoID);
  }

  void onUserSearchPetType({required String searchText}) async {
    searchText = searchText.toLowerCase();
    if (searchText == '') {
      filteredPetTypeInfoList = petTypeInfoList;
    } else {
      filteredPetTypeInfoList = petTypeInfoList
          .where((petTypeData) =>
              petTypeData.petTypeId.toLowerCase().contains(searchText) ||
              petTypeData.petTypeName.toLowerCase().contains(searchText))
          .toList();
    }
  }
}
