import 'package:untitled1/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/services/add_pet_type_info_services/add_pet_type_info_mock_service.dart';
import 'package:untitled1/services/add_pet_type_info_services/add_pet_type_info_service_interface.dart';

class EditPetTypeInfoViewModel {
  late List<PetChronicDiseaseModel> petChronicDiseaseList;
  // late Future<List<PetChronicDiseaseModel>> petChronicDiseaseListData;
  late AddPetTypeInfoServiceInterface service;

  EditPetTypeInfoViewModel() {
    petChronicDiseaseList = [];
    // petChronicDiseaseListData = fetchData();
    service = AddPetTypeInfoMockService();
  }

  void onUserAddPetChronicDisease(
      {required List<NutrientLimitInfoModel> nutrientLimitInfo,
      required String petChronicDiseaseID,
      required String petChronicDiseaseName}) {
    PetChronicDiseaseModel petChronicDiseaseData = PetChronicDiseaseModel(
        petChronicDiseaseID: petChronicDiseaseID,
        petChronicDiseaseName: petChronicDiseaseName,
        nutrientLimitInfo: nutrientLimitInfo);
    petChronicDiseaseList.add(petChronicDiseaseData);
  }

  Future<void> onUserEditPetTypeInfo(
      {required String petTypeID, required String petTypeName}) async {
    PetTypeInfoModel petTypeInfoData = PetTypeInfoModel(
        petTypeID: petTypeID,
        petTypeName: petTypeName,
        petChronicDisease: petChronicDiseaseList);
    service.postPetTypeInfoData(petTypeInfoData: petTypeInfoData);
  }
}
