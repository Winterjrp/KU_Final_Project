import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/pet_profile_model.dart';
import 'package:untitled1/services/pet_profile_services/pet_profile_service_interface.dart';

class PetProfileMockService implements PetProfileServiceInterface {
  @override
  Future<void> deletePetProfile({required String petID}) async {
    Box petInfoListBox = Hive.box<PetProfileModel>('petProfileListBox');
    await petInfoListBox.delete(petID);
  }
}
