import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/services/update_ingredients_services/update_ingredient_mock_service.dart';
import 'package:untitled1/services/update_ingredients_services/update_ingredient_service_interface.dart';

class UpdateIngredientViewModel {
  late UpdateIngredientServiceInterface services;
  late IngredientModel ingredientInfoTemp;
  UpdateIngredientViewModel() {
    services = UpdateIngredientMockService();
  }

  void copyIngredientInfo({required IngredientModel ingredientInfo}) {
    ingredientInfoTemp = IngredientModel(
      ingredientID: ingredientInfo.ingredientID,
      ingredientName: ingredientInfo.ingredientName,
      nutrient: List.from(
        ingredientInfo.nutrient.map(
          (nutrient) => NutrientModel(
              nutrientName: nutrient.nutrientName, amount: nutrient.amount),
        ),
      ),
    );
  }

  Future<void> onUserAddIngredient() async {
    try {
      await services.addIngredientData(ingredientData: ingredientInfoTemp);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> onUserEditIngredient() async {
    try {
      await services.editIngredientData(ingredientData: ingredientInfoTemp);
    } catch (_) {
      rethrow;
    }
  }
}
