import 'package:untitled1/constants/nutrient_list_template.dart';
import 'package:untitled1/constants/size.dart';
import 'package:untitled1/hive_models/ingredient_in_recipes_model.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/services/update_recipes_services/update_recipes_mock_service.dart';
import 'package:untitled1/services/update_recipes_services/update_recipes_service_interface.dart';

class AddRecipesViewModel {
  late UpdateRecipesServiceInterface services;
  late Future<List<IngredientModel>> ingredientListData;
  late List<IngredientModel> ingredientList;
  late List<PetTypeInfoModel> petTypeList;
  late List<IngredientInRecipeModel> ingredientInRecipeList;
  late List<NutrientModel> nutrientInRecipe;
  late List<IngredientModel> selectedIngredientList;
  late List<IngredientModel> filterIngredientList;
  late RecipeModel copiedRecipeInfo;
  late double totalAmount;

  AddRecipesViewModel() {
    services = AddRecipesMockService();
    ingredientInRecipeList = [];
    selectedIngredientList = [];
    nutrientInRecipe = List.from(
      freshNutrientListTemplate.map(
        (nutrient) => NutrientModel(
            nutrientName: nutrient.nutrientName,
            amount: nutrient.amount,
            unit: nutrient.unit),
      ),
    );
    totalAmount = 0;
  }

  void getRecipeInfo({required RecipeModel recipeInfo}) {
    copiedRecipeInfo = RecipeModel(
      recipeId: recipeInfo.recipeId,
      recipesName: recipeInfo.recipesName,
      petTypeName: recipeInfo.petTypeName,
      ingredientInRecipeList: recipeInfo.ingredientInRecipeList
          .map((e) => IngredientInRecipeModel(
              ingredient: e.ingredient, amount: e.amount))
          .toList(),
      nutrient: recipeInfo.nutrient
          .map((e) => NutrientModel(
              nutrientName: e.nutrientName, amount: e.amount, unit: e.unit))
          .toList(),
    );
    ingredientInRecipeList = copiedRecipeInfo.ingredientInRecipeList;
    selectedIngredientList = copiedRecipeInfo.ingredientInRecipeList
        .map((e) => e.ingredient)
        .toList();
    calculateTotalAmount();
    calculateNutrient();
  }

  void resetFilterIngredientList() async {
    filterIngredientList = ingredientList;
  }

  Future<void> getIngredientData() async {
    ingredientListData = services.getIngredientListData();
    ingredientList = await ingredientListData;
    filterIngredientList = ingredientList;
  }

  Future<void> getPetTypeListData() async {
    petTypeList = await services.getPetTypeInfoData();
  }

  void onUserAddIngredient() async {
    IngredientModel ingredientData;
    IngredientInRecipeModel ingredientInRecipesData;
    //auto assign ingredient
    if (ingredientInRecipeList.length == ingredientList.length - 1 &&
        !selectedIngredientList
            .any((ingredient) => ingredient.ingredientName == "")) {
      ingredientData = ingredientList.firstWhere(
        (element) => !selectedIngredientList.any(
            (selected) => element.ingredientName == selected.ingredientName),
      );
      if (!ingredientInRecipeList.any(
          (ingredientInRecipeData) => ingredientInRecipeData.amount == 0)) {
        //auto assign amount
        ingredientInRecipesData = IngredientInRecipeModel(
            ingredient: ingredientData,
            amount: double.parse(
                ((100 - totalAmount)).toStringAsFixed(decimalDigit)));
        ingredientInRecipeList.add(ingredientInRecipesData);
        selectedIngredientList.add(ingredientData);
        calculateTotalAmount();
        calculateNutrient();
      } else {
        ingredientInRecipesData =
            IngredientInRecipeModel(ingredient: ingredientData, amount: 0.0);
        ingredientInRecipeList.add(ingredientInRecipesData);
        selectedIngredientList.add(ingredientData);
      }
    } else {
      ingredientData =
          IngredientModel(ingredientId: "", ingredientName: "", nutrient: []);
      ingredientInRecipesData =
          IngredientInRecipeModel(ingredient: ingredientData, amount: 0.0);
      ingredientInRecipeList.add(ingredientInRecipesData);
      selectedIngredientList.add(ingredientData);
    }
  }

  void onUserSelectIngredient(
      {required IngredientModel ingredientData, required int index}) async {
    ingredientInRecipeList[index].ingredient = ingredientData;
    selectedIngredientList[index] = ingredientData;
    calculateNutrient();
  }

  void onUserSelectAmount(
      {required double amountData, required int index}) async {
    ingredientInRecipeList[index].amount = amountData;
    calculateTotalAmount();
    calculateNutrient();
  }

  void calculateNutrient() {
    nutrientInRecipe = List.from(
      freshNutrientListTemplate.map(
        (nutrient) => NutrientModel(
            nutrientName: nutrient.nutrientName,
            amount: nutrient.amount,
            unit: nutrient.unit),
      ),
    );
    for (int i = 0; i < selectedIngredientList.length; i++) {
      for (int j = 0; j < nutrientInRecipe.length; j++) {
        if (selectedIngredientList[i].nutrient.isNotEmpty) {
          nutrientInRecipe[j].amount +=
              selectedIngredientList[i].nutrient[j].amount *
                  ingredientInRecipeList[i].amount /
                  100;
          nutrientInRecipe[j].amount = double.parse(
              nutrientInRecipe[j].amount.toStringAsFixed(decimalDigit));
        }
      }
    }
  }

  void calculateTotalAmount() {
    totalAmount = 0;
    for (IngredientInRecipeModel ingredientInRecipeData
        in ingredientInRecipeList) {
      totalAmount += ingredientInRecipeData.amount;
      totalAmount = double.parse(totalAmount.toStringAsFixed(decimalDigit));
    }
  }

  void onUserSearchIngredient({required String searchText}) async {
    searchText = searchText.toLowerCase();
    if (searchText == '') {
      filterIngredientList = ingredientList;
    } else {
      filterIngredientList = ingredientList
          .where((ingredientData) =>
              ingredientData.ingredientId.toLowerCase().contains(searchText) ||
              ingredientData.ingredientName.toLowerCase().contains(searchText))
          .toList();
    }
  }

  Future<void> onUserDeleteIngredient({required int index}) async {
    totalAmount -= ingredientInRecipeList[index].amount;
    ingredientInRecipeList.removeAt(index);
    selectedIngredientList.removeAt(index);
    calculateNutrient();
  }

  Future<void> onUserAddRecipes({
    required String recipesID,
    required String recipesName,
    required String petTypeName,
  }) async {
    RecipeModel recipesData = RecipeModel(
        recipeId: recipesID,
        recipesName: recipesName,
        petTypeName: petTypeName,
        ingredientInRecipeList: ingredientInRecipeList,
        nutrient: nutrientInRecipe);
    try {
      await services.addRecipeData(recipesData: recipesData);
    } catch (_) {
      rethrow;
    }
  }
}
