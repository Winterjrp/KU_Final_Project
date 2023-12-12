import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/hive_models/pet_profile_model.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/normal/home/home_view_model.dart';
import 'package:untitled1/modules/normal/pet_profile/pet_profile_view.dart';

// typedef DeletePetInfoCallBack = void Function({required String petID});

class UserPetInfoCard extends StatelessWidget {
  final BuildContext context;
  final UserInfoModel userInfo;
  // final DeletePetInfoCallBack deletePetInfoCallBack;
  final PetProfileModel petProfileInfo;
  const UserPetInfoCard({
    required this.context,
    required this.userInfo,
    required this.petProfileInfo,
    // required this.deletePetInfoCallBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 3),
      height: 145,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          )),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PetProfileView(
                      userInfo: userInfo,
                      petProfileInfo: petProfileInfo,
                      isJustUpdate: false,
                    )),
          );
        },
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.pets_outlined, size: 70),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "น้อง: ${petProfileInfo.petName}",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  petProfileInfo.petWeight == -1
                      ? const SizedBox()
                      : Column(
                          children: [
                            Text("น้ำหนัก: ${petProfileInfo.petWeight} Kg",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ],
                        ),
                  Text(
                      "เลข factor: ${petProfileInfo.petFactorNumber.toString()}",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                  const Text("แก้ไขล่าสุด: 2 วันที่แล้ว",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
