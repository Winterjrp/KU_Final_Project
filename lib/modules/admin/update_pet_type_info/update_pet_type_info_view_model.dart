import 'package:untitled1/constants/nutrient_list_template.dart';
import 'package:untitled1/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/manager/service_manager.dart';
import 'package:untitled1/modules/admin/update_pet_type_info/model/edited_pet_type_model.dart';
import 'package:untitled1/services/add_pet_type_info_services/update_pet_type_info_mock_service.dart';
import 'package:untitled1/services/add_pet_type_info_services/update_pet_type_info_service.dart';
import 'package:untitled1/services/add_pet_type_info_services/update_pet_type_info_service_interface.dart';

class UpdatePetTypeInfoViewModel {
  late Future<List<PetChronicDiseaseModel>> petChronicDiseaseListData;
  late List<PetChronicDiseaseModel> petChronicDiseaseList;
  late List<PetChronicDiseaseModel> filteredPetChronicDiseaseList;
  late List<NutrientLimitInfoModel> defaultNutrientLimitList;
  late List<NutrientLimitInfoModel> petChronicDiseaseNutrientLimitList;
  late List<String> deletedPetChronicDiseaseList;
  late UpdatePetTypeInfoServiceInterface service;

  UpdatePetTypeInfoViewModel() {
    petChronicDiseaseListData = fetchData();
    service = ServiceManager.isRealService
        ? UpdatePetTypeInfoService()
        : UpdatePetTypeInfoMockService();
    petChronicDiseaseNutrientLimitList = List.from(
      secondaryFreshNutrientListTemplate.map(
        (e) => NutrientLimitInfoModel(
            nutrientName: e.nutrientName, min: 0, max: 100, unit: e.unit),
      ),
    );
    deletedPetChronicDiseaseList = [];
  }

  Future<List<PetChronicDiseaseModel>> fetchData() async {
    return [];
  }

  void onMinAmountChange({required int index, required double amount}) async {
    defaultNutrientLimitList[index].min = amount;
  }

  void onMaxAmountChange({required int index, required double amount}) async {
    defaultNutrientLimitList[index].max = amount;
  }

  void onUserAddPetChronicDisease(
      {required List<NutrientLimitInfoModel> nutrientLimitInfo,
      required String petChronicDiseaseID,
      required String petChronicDiseaseName}) {
    PetChronicDiseaseModel petChronicDiseaseData = PetChronicDiseaseModel(
        petChronicDiseaseId: petChronicDiseaseID,
        petChronicDiseaseName: petChronicDiseaseName,
        nutrientLimitInfo: nutrientLimitInfo);
    petChronicDiseaseList.add(petChronicDiseaseData);
  }

  // void onUserEditPetChronicDisease(
  //     {required List<NutrientLimitInfoModel> nutrientLimitInfo,
  //     required String petChronicDiseaseID,
  //     required String petChronicDiseaseName}) {
  //   PetChronicDiseaseModel petChronicDiseaseData = PetChronicDiseaseModel(
  //       petChronicDiseaseID: petChronicDiseaseID,
  //       petChronicDiseaseName: petChronicDiseaseName,
  //       nutrientLimitInfo: nutrientLimitInfo);
  //   int index = petChronicDiseaseList.indexWhere(
  //     (element) => element.petChronicDiseaseID == petChronicDiseaseID,
  //   );
  //   petChronicDiseaseList[index] = petChronicDiseaseData;
  //   index = filteredPetChronicDiseaseList.indexWhere(
  //     (element) => element.petChronicDiseaseID == petChronicDiseaseID,
  //   );
  //   filteredPetChronicDiseaseList[index] = petChronicDiseaseData;
  // }

  Future<void> onUserAddPetTypeInfo(
      {required String petTypeID, required String petTypeName}) async {
    PetTypeInfoModel petTypeInfoData = PetTypeInfoModel(
        petTypeId: petTypeID,
        petTypeName: petTypeName,
        petChronicDisease: petChronicDiseaseList,
        defaultNutrientLimitList: defaultNutrientLimitList);
    await service.addPetTypeInfoData(petTypeInfoData: petTypeInfoData);
  }

  Future<void> onUserEditPetTypeInfo(
      {required String petTypeID, required String petTypeName}) async {
    PetTypeInfoModel petTypeInfoData = PetTypeInfoModel(
        petTypeId: petTypeID,
        petTypeName: petTypeName,
        petChronicDisease: petChronicDiseaseList,
        defaultNutrientLimitList: defaultNutrientLimitList);
    EditedPetTypeModel editedPetTypeData = EditedPetTypeModel(
        petTypeInfo: petTypeInfoData,
        deletedPetChronicDiseaseList: deletedPetChronicDiseaseList);
    await service.editPetTypeInfoData(petTypeInfoData: editedPetTypeData);
  }

  void onUserSearchIngredient({required String searchText}) async {
    searchText = searchText.toLowerCase();
    if (searchText == '') {
      filteredPetChronicDiseaseList = petChronicDiseaseList;
    } else {
      filteredPetChronicDiseaseList = petChronicDiseaseList
          .where((petChronicDiseaseData) =>
              petChronicDiseaseData.petChronicDiseaseId
                  .toLowerCase()
                  .contains(searchText) ||
              petChronicDiseaseData.petChronicDiseaseName
                  .toLowerCase()
                  .contains(searchText))
          .toList();
    }
  }

  void onUserDeletePetChronicDisease(
      {required PetChronicDiseaseModel petChronicDiseaseData}) {
    deletedPetChronicDiseaseList.add(petChronicDiseaseData.petChronicDiseaseId);
    petChronicDiseaseList.remove(petChronicDiseaseData);
    filteredPetChronicDiseaseList.remove(petChronicDiseaseData);
  }

  void onUserEditPetChronicDisease({required String petChronicDiseaseId}) {
    // deletedPetChronicDiseaseList.add(petChronicDiseaseId);
  }
}
