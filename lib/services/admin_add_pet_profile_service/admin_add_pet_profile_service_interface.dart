import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';

abstract class AdminAddPetProfileServiceInterface {
  Future<List<PetTypeInfoModel>> getPetTypeInfoData();
  Future<List<IngredientModel>> getIngredientListData();
}
