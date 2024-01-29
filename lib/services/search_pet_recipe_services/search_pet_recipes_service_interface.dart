import 'package:untitled1/modules/admin/admin_get_recipe/get_recipe_model.dart';

abstract class SearchRecipeServiceInterface {
  Future<GetRecipeModel> searchRecipe();
}
