import 'package:untitled1/hive_models/ingredient_in_recipes_model.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/services/add_recipes_services/add_recipes_mock_service.dart';
import 'package:untitled1/services/add_recipes_services/add_recipes_service_interface.dart';

class AddRecipesViewModel {
  late AddRecipesServiceInterface services;
  late Future<List<IngredientModel>> ingredientListData;
  late List<IngredientModel> ingredientList;
  late List<PetTypeInfoModel> petTypeList;

  late List<IngredientInRecipesModel> ingredientInRecipes;
  late List<NutrientModel> nutrientList;

  late List<IngredientModel> selectedIngredientList;
  late List<IngredientModel> ingredientInChoice;

  late Set<IngredientModel> ingredientListSet;
  late Set<IngredientModel> selectedIngredientListSet;

  AddRecipesViewModel() {
    services = AddRecipesMockService();
    ingredientInRecipes = [];
    selectedIngredientList = [];
    nutrientList = [
      NutrientModel(nutrientName: "Protein", amount: 0.0),
      NutrientModel(nutrientName: "Total lipid (fat)", amount: 0.0),
      NutrientModel(nutrientName: "Carbohydrate, by difference", amount: 0.0),
      NutrientModel(nutrientName: "Ash", amount: 0.0),
      NutrientModel(nutrientName: "Energy", amount: 0.0),
      NutrientModel(nutrientName: "Water", amount: 0.0),
      NutrientModel(nutrientName: "Fiber, total dietary", amount: 0.0),
      NutrientModel(nutrientName: "Calcium, Ca", amount: 0.0),
      NutrientModel(nutrientName: "Iron, Fe", amount: 0.0),
      NutrientModel(nutrientName: "Magnesium, Mg", amount: 0.0),
      NutrientModel(nutrientName: "Phosphorus, P", amount: 0.0),
      NutrientModel(nutrientName: "Potassium, K", amount: 0.0),
      NutrientModel(nutrientName: "Sodium, Na", amount: 0.0),
      NutrientModel(nutrientName: "Zinc, Zn", amount: 0.0),
      NutrientModel(nutrientName: "Copper, Cu", amount: 0.0),
      NutrientModel(nutrientName: "Manganese, Mn", amount: 0.0),
      NutrientModel(nutrientName: "Selenium, Se", amount: 0.0),
      NutrientModel(nutrientName: "Vitamin A, IU", amount: 0.0),
      NutrientModel(nutrientName: "Vitamin E (alpha-tocopherol)", amount: 0.0),
      NutrientModel(nutrientName: "Vitamin D", amount: 0.0),
      NutrientModel(
          nutrientName: "Vitamin C, total ascorbic acid", amount: 0.0),
      NutrientModel(nutrientName: "Thiamin", amount: 0.0),
      NutrientModel(nutrientName: "Riboflavin", amount: 0.0),
      NutrientModel(nutrientName: "Niacin", amount: 0.0),
      NutrientModel(nutrientName: "Pantothenic acid", amount: 0.0),
      NutrientModel(nutrientName: "Vitamin B-6", amount: 0.0),
      NutrientModel(nutrientName: "Vitamin B-12", amount: 0.0),
      NutrientModel(nutrientName: "Choline, total", amount: 0.0),
      NutrientModel(nutrientName: "Folic acid", amount: 0.0),
      NutrientModel(nutrientName: "Tryptophan", amount: 0.0),
      NutrientModel(nutrientName: "Threonine", amount: 0.0),
      NutrientModel(nutrientName: "Isoleucine", amount: 0.0),
      NutrientModel(nutrientName: "Leucine", amount: 0.0),
      NutrientModel(nutrientName: "Lysine", amount: 0.0),
      NutrientModel(nutrientName: "Methionine", amount: 0.0),
      NutrientModel(nutrientName: "Cystine", amount: 0.0),
      NutrientModel(nutrientName: "Phenylalanine", amount: 0.0),
      NutrientModel(nutrientName: "Tyrosine", amount: 0.0),
      NutrientModel(nutrientName: "Valine", amount: 0.0),
      NutrientModel(nutrientName: "Arginine", amount: 0.0),
      NutrientModel(nutrientName: "Histidine", amount: 0.0),
      NutrientModel(nutrientName: "Alanine", amount: 0.0),
      NutrientModel(nutrientName: "Aspartic acid", amount: 0.0),
      NutrientModel(nutrientName: "Glutamic acid", amount: 0.0),
      NutrientModel(nutrientName: "Glycine", amount: 0.0),
      NutrientModel(nutrientName: "Proline", amount: 0.0),
      NutrientModel(nutrientName: "Serine", amount: 0.0),
    ];
  }

  Future<void> getIngredientData() async {
    ingredientListData = services.getIngredientListData();
    ingredientList = await ingredientListData;
    ingredientInChoice = ingredientList;
    ingredientListSet = Set.from(ingredientList);
  }

  Future<void> getPetTypeListData() async {
    petTypeList = await services.getPetTypeInfoData();
  }

  void onUserAddIngredient() async {
    IngredientModel ingredientData =
        IngredientModel(ingredientID: "", ingredientName: "", nutrient: []);
    IngredientInRecipesModel ingredientInRecipesData =
        IngredientInRecipesModel(ingredient: ingredientData, amount: 0.0);
    ingredientInRecipes.add(ingredientInRecipesData);
    selectedIngredientList.add(ingredientData);
  }

  void onUserSelectIngredient(
      {required IngredientModel ingredientData, required int index}) async {
    ingredientInRecipes[index].ingredient = ingredientData;
    selectedIngredientList[index] = ingredientData;
    selectedIngredientListSet = Set.from(selectedIngredientList);
    ingredientInChoice =
        (ingredientListSet.difference(selectedIngredientListSet)).toList();
    calculateNutrient();
  }

  void onUserSelectAmount(
      {required double amountData, required int index}) async {
    ingredientInRecipes[index].amount = amountData;
    calculateNutrient();
  }

  void calculateNutrient() {
    nutrientList = [
      NutrientModel(nutrientName: "Protein", amount: 0.0),
      NutrientModel(nutrientName: "Total lipid (fat)", amount: 0.0),
      NutrientModel(nutrientName: "Carbohydrate, by difference", amount: 0.0),
      NutrientModel(nutrientName: "Ash", amount: 0.0),
      NutrientModel(nutrientName: "Energy", amount: 0.0),
      NutrientModel(nutrientName: "Water", amount: 0.0),
      NutrientModel(nutrientName: "Fiber, total dietary", amount: 0.0),
      NutrientModel(nutrientName: "Calcium, Ca", amount: 0.0),
      NutrientModel(nutrientName: "Iron, Fe", amount: 0.0),
      NutrientModel(nutrientName: "Magnesium, Mg", amount: 0.0),
      NutrientModel(nutrientName: "Phosphorus, P", amount: 0.0),
      NutrientModel(nutrientName: "Potassium, K", amount: 0.0),
      NutrientModel(nutrientName: "Sodium, Na", amount: 0.0),
      NutrientModel(nutrientName: "Zinc, Zn", amount: 0.0),
      NutrientModel(nutrientName: "Copper, Cu", amount: 0.0),
      NutrientModel(nutrientName: "Manganese, Mn", amount: 0.0),
      NutrientModel(nutrientName: "Selenium, Se", amount: 0.0),
      NutrientModel(nutrientName: "Vitamin A, IU", amount: 0.0),
      NutrientModel(nutrientName: "Vitamin E (alpha-tocopherol)", amount: 0.0),
      NutrientModel(nutrientName: "Vitamin D", amount: 0.0),
      NutrientModel(
          nutrientName: "Vitamin C, total ascorbic acid", amount: 0.0),
      NutrientModel(nutrientName: "Thiamin", amount: 0.0),
      NutrientModel(nutrientName: "Riboflavin", amount: 0.0),
      NutrientModel(nutrientName: "Niacin", amount: 0.0),
      NutrientModel(nutrientName: "Pantothenic acid", amount: 0.0),
      NutrientModel(nutrientName: "Vitamin B-6", amount: 0.0),
      NutrientModel(nutrientName: "Vitamin B-12", amount: 0.0),
      NutrientModel(nutrientName: "Choline, total", amount: 0.0),
      NutrientModel(nutrientName: "Folic acid", amount: 0.0),
      NutrientModel(nutrientName: "Tryptophan", amount: 0.0),
      NutrientModel(nutrientName: "Threonine", amount: 0.0),
      NutrientModel(nutrientName: "Isoleucine", amount: 0.0),
      NutrientModel(nutrientName: "Leucine", amount: 0.0),
      NutrientModel(nutrientName: "Lysine", amount: 0.0),
      NutrientModel(nutrientName: "Methionine", amount: 0.0),
      NutrientModel(nutrientName: "Cystine", amount: 0.0),
      NutrientModel(nutrientName: "Phenylalanine", amount: 0.0),
      NutrientModel(nutrientName: "Tyrosine", amount: 0.0),
      NutrientModel(nutrientName: "Valine", amount: 0.0),
      NutrientModel(nutrientName: "Arginine", amount: 0.0),
      NutrientModel(nutrientName: "Histidine", amount: 0.0),
      NutrientModel(nutrientName: "Alanine", amount: 0.0),
      NutrientModel(nutrientName: "Aspartic acid", amount: 0.0),
      NutrientModel(nutrientName: "Glutamic acid", amount: 0.0),
      NutrientModel(nutrientName: "Glycine", amount: 0.0),
      NutrientModel(nutrientName: "Proline", amount: 0.0),
      NutrientModel(nutrientName: "Serine", amount: 0.0),
    ];
    for (int i = 0; i < selectedIngredientList.length; i++) {
      for (int j = 0; j < nutrientList.length; j++) {
        nutrientList[j].amount += selectedIngredientList[i].nutrient[j].amount *
            ingredientInRecipes[i].amount /
            100;
      }
    }
  }

  Future<void> onUserDeleteIngredient({required int index}) async {
    if (selectedIngredientList[index].nutrient.isNotEmpty) {
      for (int i = 0; i < nutrientList.length; i++) {
        nutrientList[i].amount -=
            selectedIngredientList[index].nutrient[i].amount *
                ingredientInRecipes[index].amount /
                100;
      }
    }
    ingredientInRecipes.removeAt(index);
    selectedIngredientList.removeAt(index);
    selectedIngredientListSet = Set.from(selectedIngredientList);
    ingredientInChoice =
        (ingredientListSet.difference(selectedIngredientListSet)).toList();
  }

  Future<void> onUserAddRecipes({
    required String recipesID,
    required String recipesName,
    required String petTypeName,
  }) async {
    RecipesModel recipesData = RecipesModel(
        recipesID: recipesID,
        recipesName: recipesName,
        petTypeName: petTypeName,
        ingredientInRecipes: ingredientInRecipes,
        nutrient: nutrientList);
    services.postRecipesData(recipesData: recipesData);
  }
}
