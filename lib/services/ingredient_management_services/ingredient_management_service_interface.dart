import 'package:untitled1/utility/hive_models/ingredient_model.dart';

abstract class IngredientManagementServiceInterface {
  Future<List<IngredientModel>> getIngredientListData();
  Future<void> deleteIngredientInfo({required String ingredientId});
  Future<void> addIngredientData({required IngredientModel ingredientData});
  Future<void> editIngredientData({required IngredientModel ingredientData});
}
