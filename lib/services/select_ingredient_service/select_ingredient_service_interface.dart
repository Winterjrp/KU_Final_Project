import 'package:untitled1/modules/normal/select_ingredient/normal_user_search_pet_recipe_info.dart';
import 'package:untitled1/utility/hive_models/ingredient_model.dart';
import 'package:untitled1/modules/admin/admin_get_recipe/get_recipe_model.dart';

abstract class SelectIngredientServiceInterface {
  Future<List<IngredientModel>> getIngredientListData();
  Future<GetRecipeModel> searchRecipe(
      {required NormalUserSearchPetRecipeInfoModel postDataForRecipe});
}
