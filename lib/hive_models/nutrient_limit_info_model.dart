import 'package:hive/hive.dart';

part 'nutrient_limit_info_model.g.dart';

@HiveType(typeId: 5)
class NutrientLimitInfoModel {
  @HiveField(0)
  String nutrientName;

  @HiveField(1)
  double min;

  @HiveField(2)
  double max;

  NutrientLimitInfoModel({
    required this.nutrientName,
    required this.min,
    required this.max,
  });

  factory NutrientLimitInfoModel.fromJson(Map<String, dynamic> json) =>
      NutrientLimitInfoModel(
        nutrientName: json["nutrientName"],
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "nutrientName": nutrientName,
        "min": min,
        "max": max,
      };
}
