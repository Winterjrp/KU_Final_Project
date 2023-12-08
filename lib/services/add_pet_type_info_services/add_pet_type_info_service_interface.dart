import 'package:untitled1/hive_models/pet_type_info_model.dart';

abstract class AddPetTypeInfoServiceInterface {
  Future<void> postPetTypeInfoData({required PetTypeInfoModel petTypeInfoData});
}
