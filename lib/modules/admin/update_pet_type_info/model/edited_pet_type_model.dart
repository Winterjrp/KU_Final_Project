import 'dart:convert';
import 'package:untitled1/utility/hive_models/pet_type_info_model.dart';

EditedPetTypeModel homeModelFromJson(String str) =>
    EditedPetTypeModel.fromJson(json.decode(str));

String homeModelToJson(EditedPetTypeModel data) => json.encode(data.toJson());

class EditedPetTypeModel {
  PetTypeInfoModel petTypeInfo;
  List<String> deletedPetChronicDiseaseList;

  EditedPetTypeModel({
    required this.petTypeInfo,
    required this.deletedPetChronicDiseaseList,
  });

  factory EditedPetTypeModel.fromJson(Map<String, dynamic> json) =>
      EditedPetTypeModel(
        petTypeInfo: PetTypeInfoModel.fromJson(json["petTypeInfo"]),
        deletedPetChronicDiseaseList: List<String>.from(
            json["deletedPetChronicDiseaseList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "petTypeInfo": petTypeInfo.toJson(),
        "deletedPetChronicDiseaseList":
            List<dynamic>.from(deletedPetChronicDiseaseList.map((x) => x)),
      };
}
