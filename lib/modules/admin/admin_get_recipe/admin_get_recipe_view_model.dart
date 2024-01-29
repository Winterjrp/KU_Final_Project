import 'package:untitled1/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/modules/admin/admin_get_recipe/get_recipe_model.dart';
import 'package:untitled1/services/search_pet_recipe_services/add_pet_profile_service.dart';
import 'package:untitled1/services/search_pet_recipe_services/search_pet_recipes_service_interface.dart';

class AdminGetRecipeViewModel {
  late SearchRecipeServiceInterface service;
  late Future<GetRecipeModel> getRecipeDataFetch;
  late GetRecipeModel getRecipeData;
  late List<NutrientLimitInfoModel> nutrientLimitList;
  late List<SearchPetRecipeModel> searchedPetRecipesList;

  AdminGetRecipeViewModel() {
    service = SearchRecipeService();
    // selectedIngredient = [];
    fetchData();
  }

  Future<void> fetchData() async {
    getRecipeDataFetch = service.searchRecipe();
    getRecipeData = await getRecipeDataFetch;
    nutrientLimitList = getRecipeData.defaultNutrientLimitList;
    searchedPetRecipesList = getRecipeData.searchPetRecipesList;
  }
  //
  // Future<void> fetchIngredientData() async {
  //   ingredientListData = services.getIngredientListData();
  //   ingredientList = await ingredientListData;
  // }
}
