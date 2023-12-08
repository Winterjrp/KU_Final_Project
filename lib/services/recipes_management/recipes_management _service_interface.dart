import 'package:untitled1/hive_models/recipes_model.dart';

abstract class RecipesManagementServiceInterface {
  Future<List<RecipesModel>> getRecipeListData();
  Future<void> deleteRecipeListData({required String recipeID});
}
