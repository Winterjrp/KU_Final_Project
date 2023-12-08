import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/services/pet_type_info_management/pet_type_info_management_mock_service.dart';
import 'package:untitled1/services/pet_type_info_management/pet_type_info_management_service_interface.dart';

class PetTypeInfoManagementViewModel {
  late PetTypeInfoManagementServiceInterface services;
  late Future<List<PetTypeInfoModel>> petTypeInfoData;
  late List<PetTypeInfoModel> petTypeInfo;

  PetTypeInfoManagementViewModel() {
    services = PetTypeInfoManagementMockService();
  }

  Future<void> getPetTypeInfoData() async {
    petTypeInfoData = services.getPetTypeInfoData();
    petTypeInfo = await petTypeInfoData;
  }

  Future<void> deletePetTypeData({required String petTypeInfoID}) async {
    petTypeInfoData = services.getPetTypeInfoData();
    petTypeInfo = await petTypeInfoData;
  }
}
