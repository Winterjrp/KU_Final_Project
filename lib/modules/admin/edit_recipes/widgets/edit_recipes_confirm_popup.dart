import 'package:flutter/material.dart';
import 'package:untitled1/modules/admin/recipes_management/recipes_management_view.dart';

typedef EditRecipesCallBack = void Function();

class EditRecipesConfirmPopup extends StatelessWidget {
  final EditRecipesCallBack editRecipesCallBack;

  const EditRecipesConfirmPopup({
    required this.editRecipesCallBack,
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
              child: Text('ยืนยันการแก้ไขข้อมูลสูตรอาหาร?'),
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
              editRecipesCallBack();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const RecipesManagementView()),
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
