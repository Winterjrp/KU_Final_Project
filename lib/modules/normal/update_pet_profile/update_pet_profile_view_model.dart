import 'package:untitled1/hive_models/pet_profile_model.dart';
import 'package:untitled1/services/add_pet_profile_services/add_pet_profile_mock_service.dart';
import 'package:untitled1/services/add_pet_profile_services/add_pet_info_service_interface.dart';
import 'package:http/http.dart' as http;

class AddPetProfileViewModel {
  late AddPetProfileServiceInterface services;
  AddPetProfileViewModel() {
    services = AddPetProfileMockService();
  }

  Future<http.Response> onUserAddPetProfile(
      {required String petID,
      required String petName,
      required String petType,
      required String factorType,
      required double petFactorNumber,
      required double petWeight,
      required String petNeuteringStatus,
      required String petAgeType,
      required String petPhysiologyStatus,
      required List<String> petChronicDisease,
      required String petActivityType}) async {
    PetProfileModel petInfo = PetProfileModel(
        petId: petID,
        petName: petName,
        petType: petType,
        factorType: factorType,
        petFactorNumber: petFactorNumber,
        petWeight: petWeight,
        petNeuteringStatus: petNeuteringStatus,
        petAgeType: petAgeType,
        petPhysiologyStatus: petPhysiologyStatus,
        petChronicDisease: petChronicDisease,
        petActivityType: petActivityType,
        updateRecent: '');
    return await services.addPetInfo(petProfile: petInfo);
  }

  Future<http.Response> onUserEditPetProfile(
      {required String petID,
      required String petName,
      required String petType,
      required String factorType,
      required double petFactorNumber,
      required double petWeight,
      required String petNeuteringStatus,
      required String petAgeType,
      required String petPhysiologyStatus,
      required List<String> petChronicDisease,
      required String petActivityType}) async {
    PetProfileModel petInfo = PetProfileModel(
        petId: petID,
        petName: petName,
        petType: petType,
        factorType: factorType,
        petFactorNumber: petFactorNumber,
        petWeight: petWeight,
        petNeuteringStatus: petNeuteringStatus,
        petAgeType: petAgeType,
        petPhysiologyStatus: petPhysiologyStatus,
        petChronicDisease: petChronicDisease,
        petActivityType: petActivityType,
        updateRecent: '');
    return await services.updatePetInfo(petInfo: petInfo);
  }
}
