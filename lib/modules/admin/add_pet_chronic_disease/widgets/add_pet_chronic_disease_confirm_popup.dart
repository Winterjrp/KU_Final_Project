import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled1/modules/admin/add_pet_chronic_disease/add_pet_chronic_view_model.dart';
import 'package:untitled1/hive_models/nutrient_limit_info_model.dart';

typedef OnUserAddPetChronicDiseaseCallBack = void Function(
    {required List<NutrientLimitInfoModel> nutrientLimitInfo,
    required String petChronicDiseaseID,
    required String petChronicDiseaseName});

class AddPetChronicDiseaseConfirmPopup extends StatelessWidget {
  final AddPetChronicDiseaseViewModel viewModel;
  final OnUserAddPetChronicDiseaseCallBack addPetChronicDiseaseCallBack;
  final String petChronicDiseaseName;

  const AddPetChronicDiseaseConfirmPopup({
    required this.viewModel,
    required this.petChronicDiseaseName,
    required this.addPetChronicDiseaseCallBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Set the radius here
      ),
      content: const SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text('ยืนยันการเพิ่มข้อมูลโรคประจำตัวสัตง์เลี้ยง'),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
      actions: [
        SizedBox(
          width: 100,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('กลับ',
                style: TextStyle(fontSize: 17, color: Colors.black)),
          ),
        ),
        SizedBox(
          width: 100,
          height: 40,
          child: ElevatedButton(
            onPressed: () async {
              addPetChronicDiseaseCallBack(
                  nutrientLimitInfo: viewModel.nutrientLimitList,
                  petChronicDiseaseID: Random().nextInt(999).toString(),
                  petChronicDiseaseName: petChronicDiseaseName);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(58, 180, 106, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('ยืนยัน',
                style: TextStyle(fontSize: 17, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
