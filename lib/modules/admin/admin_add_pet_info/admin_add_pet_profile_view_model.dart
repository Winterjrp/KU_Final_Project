import 'package:untitled1/constants/enum/pet_activity_enum.dart';
import 'package:untitled1/constants/enum/pet_age_type_enum.dart';
import 'package:untitled1/constants/enum/pet_neutering_status_enum.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/services/admin_add_pet_profile_service/admin_add_pet_profile_service.dart';
import 'package:untitled1/services/admin_add_pet_profile_service/admin_add_pet_profile_service_interface.dart';

class AdminAddPetProfileViewModel {
  late AdminAddPetProfileServiceInterface services;
  late List<IngredientModel> selectedIngredient;
  late Future<List<PetTypeInfoModel>> petTypeInfoListData;
  late List<PetTypeInfoModel> petTypeInfoList;
  late Future<List<IngredientModel>> ingredientListData;
  late List<IngredientModel> ingredientList;

  AdminAddPetProfileViewModel() {
    services = AdminAddPetProfileService();
    selectedIngredient = [];
    fetchPetTypeData();
  }

  Future<void> fetchPetTypeData() async {
    petTypeInfoListData = services.getPetTypeInfoData();
    petTypeInfoList = await petTypeInfoListData;
  }

  Future<void> fetchIngredientData() async {
    ingredientListData = services.getIngredientListData();
    ingredientList = await ingredientListData;
  }

  // Future<http.Response> onUserAddPetProfile(
  //     {required String petID,
  //     required String petName,
  //     required String petType,
  //     required String factorType,
  //     required double petFactorNumber,
  //     required double petWeight,
  //     required String petNeuteringStatus,
  //     required String petAgeType,
  //     required String petPhysiologyStatus,
  //     required List<String> petChronicDisease,
  //     required String petActivityType}) async {
  //   PetProfileModel petInfo = PetProfileModel(
  //       petId: petID,
  //       petName: petName,
  //       petType: petType,
  //       factorType: factorType,
  //       petFactorNumber: petFactorNumber,
  //       petWeight: petWeight,
  //       petNeuteringStatus: petNeuteringStatus,
  //       petAgeType: petAgeType,
  //       petPhysiologyStatus: petPhysiologyStatus,
  //       petChronicDisease: petChronicDisease,
  //       petActivityType: petActivityType,
  //       updateRecent: '');
  //   return await services.addPetInfo(petProfile: petInfo);
  // }
  //
  // Future<http.Response> onUserEditPetProfile(
  //     {required String petID,
  //     required String petName,
  //     required String petType,
  //     required String factorType,
  //     required double petFactorNumber,
  //     required double petWeight,
  //     required String petNeuteringStatus,
  //     required String petAgeType,
  //     required String petPhysiologyStatus,
  //     required List<String> petChronicDisease,
  //     required String petActivityType}) async {
  //   PetProfileModel petInfo = PetProfileModel(
  //       petId: petID,
  //       petName: petName,
  //       petType: petType,
  //       factorType: factorType,
  //       petFactorNumber: petFactorNumber,
  //       petWeight: petWeight,
  //       petNeuteringStatus: petNeuteringStatus,
  //       petAgeType: petAgeType,
  //       petPhysiologyStatus: petPhysiologyStatus,
  //       petChronicDisease: petChronicDisease,
  //       petActivityType: petActivityType,
  //       updateRecent: '');
  //   return await services.updatePetInfo(petInfo: petInfo);
  // }

  double calculatePetFactorNumber(
      {required String petID,
      required String petName,
      required String petType,
      required double petWeight,
      required String petNeuteringStatus,
      required String petAgeType,
      required String petPhysiologyStatus,
      required List<String> petChronicDisease,
      required String petActivityType}) {
    if (petNeuteringStatus == PetNeuterStatusEnum.neuterStatusChoice2) {
      if (petAgeType == PetAgeTypeEnum.petAgeChoice1) {
        if (petActivityType == PetActivityLevelEnum.activityLevelChoice1) {
          return 1.4;
        } else if (petActivityType ==
            PetActivityLevelEnum.activityLevelChoice2) {
          return 1.6;
        } else {
          return 1.8;
        }
      } else if (petAgeType == PetAgeTypeEnum.petAgeChoice2) {
        if (petActivityType == PetActivityLevelEnum.activityLevelChoice1) {
          return 1;
        } else if (petActivityType ==
            PetActivityLevelEnum.activityLevelChoice2) {
          return 1.2;
        } else {
          return 1.4;
        }
      } else {
        if (petActivityType == PetActivityLevelEnum.activityLevelChoice1) {
          return 0.8;
        } else if (petActivityType ==
            PetActivityLevelEnum.activityLevelChoice2) {
          return 1;
        } else {
          return 1.2;
        }
      }
    } else {
      if (petAgeType == PetAgeTypeEnum.petAgeChoice1) {
        if (petActivityType == PetActivityLevelEnum.activityLevelChoice1) {
          return 1.4;
        } else if (petActivityType ==
            PetActivityLevelEnum.activityLevelChoice2) {
          return 1.6;
        } else {
          return 1.8;
        }
      } else if (petAgeType == PetAgeTypeEnum.petAgeChoice2) {
        if (petActivityType == PetActivityLevelEnum.activityLevelChoice1) {
          return 1;
        } else if (petActivityType ==
            PetActivityLevelEnum.activityLevelChoice2) {
          return 1.2;
        } else {
          return 1.4;
        }
      } else {
        if (petActivityType == PetActivityLevelEnum.activityLevelChoice1) {
          return 0.8;
        } else if (petActivityType ==
            PetActivityLevelEnum.activityLevelChoice2) {
          return 1;
        } else {
          return 1.2;
        }
      }
    }
  }
}
