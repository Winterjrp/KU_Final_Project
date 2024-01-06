import 'package:untitled1/hive_models/ingredient_model.dart';

abstract class UpdateIngredientServiceInterface {
  Future<void> addIngredientData({required IngredientModel ingredientData});
  Future<void> editIngredientData({required IngredientModel ingredientData});
}
