import 'package:flutter/material.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/modules/admin/edit_pet_type_info/edit_pet_type_info_view.dart';
import 'package:untitled1/modules/admin/pet_type_info/widgets/delete_pet_type_info_confirm_popup.dart';
import 'package:untitled1/modules/admin/pet_type_info/widgets/pet_chronic_disease_card.dart';

typedef DeletePetTypeInfoCallBack = void Function(
    {required String petTypeInfoID});

class PetTypeInfoView extends StatelessWidget {
  final DeletePetTypeInfoCallBack deletePetTypeInfoCallBack;
  final PetTypeInfoModel petTypeInfo;
  const PetTypeInfoView(
      {required this.petTypeInfo,
      required this.deletePetTypeInfoCallBack,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    _header(),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Spacer(),
                              _editRecipeInfoButton(context: context),
                              const SizedBox(width: 15),
                              _deleteRecipeInfoButton(context: context),
                            ],
                          ),
                          const Text("โรคประจำตัวสัตว์เลี้ยง",
                              style: TextStyle(fontSize: 25)),
                          const SizedBox(height: 10),
                          _petTypeInfo(height: height, context: context),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deleteRecipeInfoButton({required BuildContext context}) {
    // IngredientInfoViewModel viewModel = IngredientInfoViewModel();
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return DeletePetTypeInfoConfirmPopup(
                deletePetTypeInfoCallBack: deletePetTypeInfoCallBack,
                petTypeInfoID: petTypeInfo.petTypeID,
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.delete_rounded, color: Colors.white),
            SizedBox(width: 5),
            Text('ลบข้อมูล',
                style: TextStyle(fontSize: 17, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _editRecipeInfoButton({required BuildContext context}) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EditPetTypeInfoView(petTypeInfo: petTypeInfo)),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.edit, color: Colors.white),
            SizedBox(width: 10),
            Text('แก้ไข', style: TextStyle(fontSize: 17, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return SizedBox(
      child: Text(
        "ข้อมูลชนิดสัตว์เลี้ยง: ${petTypeInfo.petTypeName}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 42,
          // color: kPrimaryDarkColor,
        ),
      ),
    );
  }

  Widget _petTypeInfo({required double height, required BuildContext context}) {
    return SingleChildScrollView(
        child: Container(
      constraints: BoxConstraints(maxHeight: height * 0.72),
      height: 75.0 * petTypeInfo.petChronicDisease.length,
      child: ListView.builder(
        itemCount: petTypeInfo.petChronicDisease.length,
        itemBuilder: (context, index) {
          return PetChronicDiseaseCard(
            index: index,
            context: context,
            petChronicDiseaseData: petTypeInfo.petChronicDisease[index],
          );
        },
      ),
    ));
  }
}
