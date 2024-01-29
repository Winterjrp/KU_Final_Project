import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/modules/admin/update_pet_type_info/model/edited_pet_type_model.dart';

abstract class UpdatePetTypeInfoServiceInterface {
  Future<void> addPetTypeInfoData({required PetTypeInfoModel petTypeInfoData});
  Future<void> editPetTypeInfoData(
      {required EditedPetTypeModel petTypeInfoData});
}
