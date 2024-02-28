import 'dart:convert';
import 'package:untitled1/utility/hive_models/nutrient_limit_info_model.dart';

PetPhysiologicalModel petPhysiologicalNutrientLimitModelFromJson(String str) =>
    PetPhysiologicalModel.fromJson(json.decode(str));

String petPhysiologicalNutrientLimitModelToJson(PetPhysiologicalModel data) =>
    json.encode(data.toJson());

class PetPhysiologicalModel {
  String petTypeName;
  String petTypeId;
  String petPhysiologicalId;
  String petPhysiologicalName;
  String description;
  List<NutrientLimitInfoModel> nutrientLimitInfo;

  PetPhysiologicalModel({
    required this.petTypeName,
    required this.petTypeId,
    required this.petPhysiologicalId,
    required this.petPhysiologicalName,
    required this.description,
    required this.nutrientLimitInfo,
  });

  factory PetPhysiologicalModel.fromJson(Map<String, dynamic> json) =>
      PetPhysiologicalModel(
        petTypeName: json["petType"],
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
        "petType": petTypeName,
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
