import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:untitled1/utility/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/utility/hive_models/pet_physiological_nutrient_limit_model.dart';

part 'pet_type_info_model.g.dart';

PetTypeInfoModel petTypeInfoModelFromJson(String str) =>
    PetTypeInfoModel.fromJson(json.decode(str));
String petTypeInfoModelToJson(PetTypeInfoModel data) =>
    json.encode(data.toJson());

@HiveType(typeId: 3)
class PetTypeInfoModel {
  @HiveField(0)
  String petTypeId;

  @HiveField(1)
  String petTypeName;

  @HiveField(2)
  List<PetPhysiologicalModel> petPhysiological;

  @HiveField(3)
  List<PetChronicDiseaseModel> petChronicDisease;

  PetTypeInfoModel({
    required this.petTypeId,
    required this.petTypeName,
    required this.petPhysiological,
    required this.petChronicDisease,
  });

  factory PetTypeInfoModel.fromJson(Map<String, dynamic> json) =>
      PetTypeInfoModel(
        petTypeId: json["petTypeId"],
        petTypeName: json["petTypeName"],
        petPhysiological: List<PetPhysiologicalModel>.from(
          json["petPhysiological"].map(
            (x) => PetPhysiologicalModel.fromJson(x),
          ),
        ),
        petChronicDisease: List<PetChronicDiseaseModel>.from(
          json["petChronicDisease"].map(
            (x) => PetChronicDiseaseModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "petTypeId": petTypeId,
        "petTypeName": petTypeName,
        "petPhysiological":
            List<dynamic>.from(petPhysiological.map((x) => x.toJson())),
        "petChronicDisease":
            List<dynamic>.from(petChronicDisease.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 4)
class PetChronicDiseaseModel {
  @HiveField(0)
  String petChronicDiseaseId;

  @HiveField(1)
  String petChronicDiseaseName;

  @HiveField(2)
  List<NutrientLimitInfoModel> nutrientLimitInfo;

  PetChronicDiseaseModel({
    required this.petChronicDiseaseId,
    required this.petChronicDiseaseName,
    required this.nutrientLimitInfo,
  });

  factory PetChronicDiseaseModel.fromJson(Map<String, dynamic> json) =>
      PetChronicDiseaseModel(
        petChronicDiseaseId: json["petChronicDiseaseId"],
        petChronicDiseaseName: json["petChronicDiseaseName"],
        nutrientLimitInfo: List<NutrientLimitInfoModel>.from(
          json["NutrientLimitInfo"].map(
            (x) => NutrientLimitInfoModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "petChronicDiseaseId": petChronicDiseaseId,
        "petChronicDiseaseName": petChronicDiseaseName,
        "NutrientLimitInfo": List<dynamic>.from(
          nutrientLimitInfo.map(
            (x) => x.toJson(),
          ),
        ),
      };
}
