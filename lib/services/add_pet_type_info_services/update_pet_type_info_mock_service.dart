import 'package:hive/hive.dart';
import 'package:untitled1/utility/hive_models/pet_type_info_model.dart';
import 'package:untitled1/modules/admin/update_pet_type_info/model/edited_pet_type_model.dart';
import 'package:untitled1/services/add_pet_type_info_services/update_pet_type_info_service_interface.dart';

class UpdatePetTypeInfoMockService
    implements UpdatePetTypeInfoServiceInterface {
  @override
  Future<void> addPetTypeInfoData(
      {required PetTypeInfoModel petTypeInfoData}) async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Box petTypeInfoDataListBox =
        Hive.box<PetTypeInfoModel>('petTypeInfoListBox');
    await petTypeInfoDataListBox.put(
        petTypeInfoData.petTypeId, petTypeInfoData);
  }

  @override
  Future<void> editPetTypeInfoData(
      {required EditedPetTypeModel petTypeInfoData}) async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Box petTypeInfoDataListBox =
        Hive.box<PetTypeInfoModel>('petTypeInfoListBox');
    await petTypeInfoDataListBox.put(
        petTypeInfoData.petTypeInfo.petTypeId, petTypeInfoData.petTypeInfo);
  }
}
