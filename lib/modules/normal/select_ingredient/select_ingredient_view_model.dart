import 'package:untitled1/constants/enum/pet_activity_enum.dart';
import 'package:untitled1/constants/enum/pet_age_type_enum.dart';
import 'package:untitled1/constants/enum/pet_neutering_status_enum.dart';
import 'package:untitled1/hive_models/pet_profile_model.dart';
import 'package:untitled1/services/add_pet_profile_services/add_pet_profile_mock_service.dart';
import 'package:untitled1/services/add_pet_profile_services/add_pet_info_service_interface.dart';
import 'package:http/http.dart' as http;

class SelectIngredientViewModel {
  late List<String> selectedIngredient;
  // late AddPetProfileServiceInterface services;
  SelectIngredientViewModel() {
    // services = AddPetProfileMockService();
    selectedIngredient = [];
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
}
