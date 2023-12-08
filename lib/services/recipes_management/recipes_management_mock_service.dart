import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/services/recipes_management/recipes_management _service_interface.dart';

class RecipesManagementMockService
    implements RecipesManagementServiceInterface {
  @override
  Future<List<RecipesModel>> getRecipeListData() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    final recipesListBox = await Hive.openBox<RecipesModel>('recipesListBox');
    List<RecipesModel> recipesListData = recipesListBox.values.toList();
    return recipesListData;
  }

  @override
  Future<void> deleteRecipeListData({required String recipeID}) async {
    Box recipeListBox = Hive.box<RecipesModel>('recipesListBox');
    await recipeListBox.delete(recipeID);
  }
}
