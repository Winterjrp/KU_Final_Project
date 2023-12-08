import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/services/add_pet_type_info_services/add_pet_type_info_service_interface.dart';

class AddPetTypeInfoMockService implements AddPetTypeInfoServiceInterface {
  @override
  Future<void> postPetTypeInfoData(
      {required PetTypeInfoModel petTypeInfoData}) async {
    Box petTypeInfoDataListBox =
        Hive.box<PetTypeInfoModel>('petTypeInfoListBox');
    await petTypeInfoDataListBox.put(
        petTypeInfoData.petTypeID, petTypeInfoData);
  }
}
