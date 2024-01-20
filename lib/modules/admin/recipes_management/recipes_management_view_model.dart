import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/services/recipes_management/recipes_management_mock_service.dart';
import 'package:untitled1/services/recipes_management/recipes_management _service_interface.dart';

class RecipesManagementViewModel {
  late List<RecipeModel> recipesList;
  late List<RecipeModel> filterRecipesList;
  late Future<List<RecipeModel>> recipesListData;
  late RecipesManagementServiceInterface service;

  RecipesManagementViewModel() {
    service = RecipesManagementMockService();
    fetchRecipesListData();
  }

  Future<void> fetchRecipesListData() async {
    recipesListData = service.getRecipeListData();
    recipesList = await recipesListData;
    filterRecipesList = recipesList;
  }

  Future<void> onUserDeleteRecipe({required String recipeId}) async {
    try {
      await service.deleteRecipeData(recipeId: recipeId);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> onUserEditRecipe({required RecipeModel recipeInfo}) async {
    try {
      await service.editRecipeData(recipeData: recipeInfo);
    } catch (_) {
      rethrow;
    }
  }

  void onUserSearchIngredient({required String searchText}) async {
    searchText = searchText.toLowerCase();
    if (searchText == '') {
      filterRecipesList = recipesList;
    } else {
      filterRecipesList = recipesList
          .where((recipesData) =>
              recipesData.recipeId.toLowerCase().contains(searchText) ||
              recipesData.recipesName.toLowerCase().contains(searchText) ||
              recipesData.petTypeName.toLowerCase().contains(searchText))
          .toList();
    }
  }
}
