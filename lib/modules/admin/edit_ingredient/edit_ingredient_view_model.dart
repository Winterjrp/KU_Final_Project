import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/services/edit_ingredients_services/edit_ingredient_mock_service.dart';
import 'package:untitled1/services/edit_ingredients_services/edit_ingredient_service_interface.dart';

class EditIngredientViewModel {
  late EditIngredientServiceInterface services;
  late List<NutrientModel> nutrientList;

  EditIngredientViewModel() {
    services = EditIngredientMockService();
  }

  void getIngredientData({required List<NutrientModel> nutrientListData}) {
    nutrientList = nutrientListData
        .map((nutrient) => NutrientModel(
              nutrientName: nutrient.nutrientName,
              amount: nutrient.amount,
            ))
        .toList();
  }

  Future<void> onUserEditIngredient(
      {required String ingredientID, required String ingredientName}) async {
    IngredientModel ingredientData = IngredientModel(
        ingredientID: ingredientID,
        ingredientName: ingredientName,
        nutrient: nutrientList);
    services.updateIngredientData(ingredientData: ingredientData);
  }
}
