import 'package:flutter/material.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/normal/home/home_view.dart';
import 'package:untitled1/modules/normal/pet_profile/pet_profile_view_model.dart';

// typedef DeletePetInfoCallBack = void Function({required String petID});

class DeletePetProfileConfirmPopup extends StatelessWidget {
  const DeletePetProfileConfirmPopup({
    required this.petProfileViewModel,
    required this.userInfo,
    required this.petID,
    Key? key,
  }) : super(key: key);

  final PetProfileViewModel petProfileViewModel;
  final UserInfoModel userInfo;
  final String petID;

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
              child: Text('ยืนยันการลบข้อมูลสัตว์เลี้ยง'),
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
              petProfileViewModel.onUserDeletePetProfile(petID: petID);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeView(userInfo: userInfo)),
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
