import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/services/recipes_management/recipes_management _service_interface.dart';

class RecipesManagementMockService
    implements RecipesManagementServiceInterface {
  @override
  Future<List<RecipeModel>> getRecipeListData() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    final recipesListBox = await Hive.openBox<RecipeModel>('recipesListBox');
    List<RecipeModel> recipesListData = recipesListBox.values.toList();
    return recipesListData;
  }

  @override
  Future<void> deleteRecipeData({required String recipeId}) async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Box recipeListBox = Hive.box<RecipeModel>('recipesListBox');
    await recipeListBox.delete(recipeId);
  }

  @override
  Future<void> addRecipeData({required RecipeModel recipesData}) async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Box recipesListBox = Hive.box<RecipeModel>('recipesListBox');
    await recipesListBox.put(recipesData.recipeId, recipesData);
  }

  @override
  Future<void> editRecipeData({required RecipeModel recipeData}) async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Box recipesListBox = Hive.box<RecipeModel>('recipesListBox');
    await recipesListBox.put(recipeData.recipeId, recipeData);
  }
}
