import 'package:untitled1/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/services/recipes_management/recipes_management_mock_service.dart';
import 'package:untitled1/services/recipes_management/recipes_management _service_interface.dart';

class RecipesManagementViewModel {
  late List<RecipesModel> recipesList;
  late Future<List<RecipesModel>> recipesListData;
  late RecipesManagementServiceInterface service;

  RecipesManagementViewModel() {
    service = RecipesManagementMockService();
    fetchRecipesListData();
  }

  Future<void> fetchRecipesListData() async {
    recipesListData = service.getRecipeListData();
    recipesList = await recipesListData;
  }

  Future<void> onUserDeleteRecipe({required String recipeID}) async {
    service.deleteRecipeListData(recipeID: recipeID);
  }

  // void onUserAddPetChronicDisease(
  //     {required List<NutrientLimitInfoModel> nutrientLimitInfo,
  //     required String petChronicDiseaseID,
  //     required String petChronicDiseaseName}) {
  //   PetChronicDiseaseModel petChronicDiseaseData = PetChronicDiseaseModel(
  //       petChronicDiseaseID: petChronicDiseaseID,
  //       petChronicDiseaseName: petChronicDiseaseName,
  //       nutrientLimitInfo: nutrientLimitInfo);
  //   petChronicDiseaseList.add(petChronicDiseaseData);
  // }
  //
  // Future<void> onUserAddPetTypeInfo(
  //     {required String petTypeID, required String petTypeName}) async {
  //   PetTypeInfoModel petTypeInfoData = PetTypeInfoModel(
  //       petTypeID: petTypeID,
  //       petTypeName: petTypeName,
  //       petChronicDisease: petChronicDiseaseList);
  //   service.postPetTypeInfoData(petTypeInfoData: petTypeInfoData);
  // }
}
