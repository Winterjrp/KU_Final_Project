import 'dart:convert';

import 'package:untitled1/hive_models/pet_profile_model.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  List<PetProfileModel> petList;

  HomeModel({
    required this.petList,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        petList: List<PetProfileModel>.from(
            json["petList"].map((x) => PetProfileModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "petList": List<dynamic>.from(petList.map((x) => x.toJson())),
      };
}
