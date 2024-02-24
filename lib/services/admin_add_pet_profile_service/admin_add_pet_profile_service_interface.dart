import 'package:untitled1/utility/hive_models/ingredient_model.dart';
import 'package:untitled1/utility/hive_models/pet_type_info_model.dart';
import 'package:untitled1/modules/admin/admin_add_pet_info/models/post_for_recipe_model.dart';
import 'package:untitled1/modules/admin/admin_get_recipe/get_recipe_model.dart';

abstract class AdminAddPetProfileServiceInterface {
  Future<List<PetTypeInfoModel>> getPetTypeInfoData();
  Future<List<IngredientModel>> getIngredientListData();
  Future<GetRecipeModel> searchRecipe(
      {required PostDataForRecipeModel postDataForRecipe});
}
