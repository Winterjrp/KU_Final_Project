import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/services/ingredient_management_services/ingredient_management_mock_service.dart';
import 'package:untitled1/services/ingredient_management_services/ingredient_management_service_interface.dart';

class IngredientManagementViewModel {
  late IngredientManagementServiceInterface services;
  late Future<List<IngredientModel>> ingredientListData;
  late List<IngredientModel> ingredientList;

  IngredientManagementViewModel() {
    services = IngredientManagementMockService();
  }

  Future<void> getIngredientData() async {
    ingredientListData = services.getIngredientListData();
    ingredientList = await ingredientListData;
  }
}
