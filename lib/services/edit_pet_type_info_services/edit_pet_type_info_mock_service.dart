import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/services/edit_pet_type_info_services/edit_pet_type_info_service_interface.dart';

class EditPetTypeInfoMockService implements EditPetTypeInfoServiceInterface {
  @override
  Future<void> updatePetTypeInfoData(
      {required PetTypeInfoModel petTypeInfoData}) async {
    Box petTypeInfoDataListBox =
        Hive.box<PetTypeInfoModel>('petTypeInfoListBox');
    await petTypeInfoDataListBox.put(
        petTypeInfoData.petTypeID, petTypeInfoData);
  }
}
