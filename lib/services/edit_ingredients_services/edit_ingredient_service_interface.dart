import 'package:untitled1/hive_models/ingredient_model.dart';

abstract class EditIngredientServiceInterface {
  Future<void> updateIngredientData({required IngredientModel ingredientData});
}
