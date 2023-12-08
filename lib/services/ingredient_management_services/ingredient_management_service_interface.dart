import 'package:untitled1/hive_models/ingredient_model.dart';

abstract class IngredientManagementServiceInterface {
  Future<List<IngredientModel>> getIngredientListData();
}
