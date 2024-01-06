import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/services/ingredient_management_services/ingredient_management_mock_service.dart';
import 'package:untitled1/services/ingredient_management_services/ingredient_management_service_interface.dart';

class IngredientManagementViewModel {
  late IngredientManagementServiceInterface services;
  late Future<List<IngredientModel>> ingredientListData;
  late List<IngredientModel> ingredientList;
  late List<IngredientModel> filterIngredientList;

  IngredientManagementViewModel() {
    services = IngredientManagementMockService();
  }

  Future<void> getIngredientData() async {
    ingredientListData = services.getIngredientListData();
    ingredientList = await ingredientListData;
    filterIngredientList = ingredientList;
  }

  void onUserSearchIngredient({required String searchText}) async {
    searchText = searchText.toLowerCase();
    if (searchText == '') {
      filterIngredientList = ingredientList;
    } else {
      filterIngredientList = ingredientList
          .where((ingredientData) =>
              ingredientData.ingredientID.toLowerCase().contains(searchText) ||
              ingredientData.ingredientName.toLowerCase().contains(searchText))
          .toList();
    }
  }
}
