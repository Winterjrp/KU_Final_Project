import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/services/add_ingredients_services/add_ingredient_mock_service.dart';
import 'package:untitled1/services/add_ingredients_services/add_ingredient_service_interface.dart';

class AddIngredientViewModel {
  late AddIngredientServiceInterface services;
  late List<NutrientModel> nutrientList;
  AddIngredientViewModel() {
    services = AddIngredientMockService();
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

  Future<void> onUserAddIngredient(
      {required String ingredientID, required String ingredientName}) async {
    IngredientModel ingredientData = IngredientModel(
        ingredientID: ingredientID,
        ingredientName: ingredientName,
        nutrient: nutrientList);
    services.postIngredientData(ingredientData: ingredientData);
  }
}
