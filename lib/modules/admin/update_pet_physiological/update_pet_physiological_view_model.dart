import 'package:untitled1/utility/hive_models/nutrient_limit_info_model.dart';

class UpdatePetPhysiologicalViewModel {
  late List<NutrientLimitInfoModel> nutrientLimitList;

  void onMinAmountChange({required int index, required double amount}) async {
    nutrientLimitList[index].min = amount;
  }

  void onMaxAmountChange({required int index, required double amount}) async {
    nutrientLimitList[index].max = amount;
  }
}
