import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/services/update_recipes_services/update_recipes_service_interface.dart';

class AddRecipesMockService implements UpdateRecipesServiceInterface {
  @override
  Future<List<IngredientModel>> getIngredientListData() async {
    await Future.delayed(const Duration(milliseconds: 1200), () {});
    final ingredientListBox =
        await Hive.openBox<IngredientModel>('ingredientListBox');
    List<IngredientModel> ingredientListData =
        ingredientListBox.values.toList();
    return ingredientListData;
  }

  @override
  Future<List<PetTypeInfoModel>> getPetTypeInfoData() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    final petTypeInfoListBox =
        await Hive.openBox<PetTypeInfoModel>('petTypeInfoListBox');
    List<PetTypeInfoModel> petTypeInfoListData =
        petTypeInfoListBox.values.toList();
    return petTypeInfoListData;
  }

  @override
  Future<void> addRecipeData({required RecipeModel recipesData}) async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Box recipesListBox = Hive.box<RecipeModel>('recipesListBox');
    await recipesListBox.put(recipesData.recipeId, recipesData);
  }
}
