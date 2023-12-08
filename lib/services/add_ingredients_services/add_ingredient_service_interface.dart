import 'package:untitled1/hive_models/ingredient_model.dart';

abstract class AddIngredientServiceInterface {
  Future<void> postIngredientData({required IngredientModel ingredientData});
}
