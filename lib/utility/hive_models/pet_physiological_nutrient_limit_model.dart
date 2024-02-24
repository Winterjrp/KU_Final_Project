import 'dart:convert';
import 'package:untitled1/utility/hive_models/nutrient_limit_info_model.dart';

PetPhysiologicalNutrientLimitModel petPhysiologicalNutrientLimitModelFromJson(
        String str) =>
    PetPhysiologicalNutrientLimitModel.fromJson(json.decode(str));

String petPhysiologicalNutrientLimitModelToJson(
        PetPhysiologicalNutrientLimitModel data) =>
    json.encode(data.toJson());

class PetPhysiologicalNutrientLimitModel {
  String petType;
  String petTypeId;
  String petPhysiologicalId;
  String petPhysiologicalName;
  String description;
  List<NutrientLimitInfoModel> nutrientLimitInfo;

  PetPhysiologicalNutrientLimitModel({
    required this.petType,
    required this.petTypeId,
    required this.petPhysiologicalId,
    required this.petPhysiologicalName,
    required this.description,
    required this.nutrientLimitInfo,
  });

  factory PetPhysiologicalNutrientLimitModel.fromJson(
          Map<String, dynamic> json) =>
      PetPhysiologicalNutrientLimitModel(
        petType: json["petType"],
        petTypeId: json["petTypeId"],
        petPhysiologicalId: json["petPhysiologicalId"],
        petPhysiologicalName: json["petPhysiologicalName"],
        description: json["description"],
        nutrientLimitInfo: List<NutrientLimitInfoModel>.from(
          json["NutrientLimitInfo"].map(
            (x) => NutrientLimitInfoModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "petType": petType,
        "petTypeId": petTypeId,
        "petPhysiologicalId": petPhysiologicalId,
        "petPhysiologicalName": petPhysiologicalName,
        "description": description,
        "NutrientLimitInfo": List<dynamic>.from(
          nutrientLimitInfo.map(
            (x) => x.toJson(),
          ),
        ),
      };
}
