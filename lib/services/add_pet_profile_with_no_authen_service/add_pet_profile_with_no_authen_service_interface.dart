import 'package:untitled1/utility/hive_models/pet_type_info_model.dart';

abstract class AddPetProfileWithNoAuthenticationServiceInterface {
  Future<List<PetTypeInfoModel>> getPetTypeInfoData();
}
