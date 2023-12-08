import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/add_ingredient/add_ingredient_view_model.dart';
import 'package:untitled1/modules/admin/ingredient_management/ingredient_management_view.dart';

// typedef AddPetInfoCallBack = void Function({required String petID});

class AddIngredientConfirmPopup extends StatelessWidget {
  const AddIngredientConfirmPopup({
    required this.viewModel,
    required this.userInfo,
    required this.ingredientName,
    Key? key,
  }) : super(key: key);

  final AddIngredientViewModel viewModel;
  // final AddPetInfoCallBack deletePetInfoCallBack;
  final UserInfoModel userInfo;
  final String ingredientName;

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
              child: Text('ยืนยันการเพิ่มข้อมูลวัตถุดิบ'),
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
              viewModel.onUserAddIngredient(
                ingredientID: Random().nextInt(999).toString(),
                ingredientName: ingredientName,
              );
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        IngredientManagementView(userInfo: userInfo)),
              );
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
