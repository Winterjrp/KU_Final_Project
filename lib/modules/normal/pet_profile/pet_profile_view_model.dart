import 'package:untitled1/modules/normal/home/models/home_model.dart';
import 'package:untitled1/services/pet_profile_services/pet_profile_mock_service.dart';
import 'package:untitled1/services/pet_profile_services/pet_profile_service_interface.dart';

class PetProfileViewModel {
  late PetProfileServiceInterface services;

  PetProfileViewModel() {
    services = PetProfileMockService();
  }

  Future<void> onUserDeletePetProfile({required String petID}) async {
    await services.deletePetProfile(petID: petID);
  }
}
