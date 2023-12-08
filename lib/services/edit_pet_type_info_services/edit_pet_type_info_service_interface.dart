import 'package:untitled1/hive_models/pet_type_info_model.dart';

abstract class EditPetTypeInfoServiceInterface {
  Future<void> updatePetTypeInfoData(
      {required PetTypeInfoModel petTypeInfoData});
}
