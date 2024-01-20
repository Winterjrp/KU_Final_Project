import 'package:untitled1/hive_models/recipes_model.dart';

abstract class RecipesManagementServiceInterface {
  Future<List<RecipeModel>> getRecipeListData();
  Future<void> deleteRecipeData({required String recipeId});
  Future<void> addRecipeData({required RecipeModel recipesData});
  Future<void> editRecipeData({required RecipeModel recipeData});
}
