import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/hive_models/recipes_model.dart';

abstract class EditRecipesServiceInterface {
  Future<List<IngredientModel>> getIngredientListData();
  Future<List<PetTypeInfoModel>> getPetTypeInfoData();
  Future<void> updateRecipesData({required RecipeModel recipesData});
}
