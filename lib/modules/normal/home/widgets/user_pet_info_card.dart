import 'package:flutter/material.dart';
import 'package:untitled1/hive_models/pet_profile_model.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/normal/home/home_view_model.dart';
import 'package:untitled1/modules/normal/pet_profile/pet_profile_view.dart';

// typedef DeletePetInfoCallBack = void Function({required String petID});

class UserPetInfoCard extends StatelessWidget {
  final BuildContext context;
  final int index;
  final HomeViewModel homeViewModel;
  final UserInfoModel userInfo;
  // final DeletePetInfoCallBack deletePetInfoCallBack;
  final PetProfileModel petProfileInfo;
  const UserPetInfoCard({
    required this.context,
    required this.index,
    required this.homeViewModel,
    required this.userInfo,
    required this.petProfileInfo,
    // required this.deletePetInfoCallBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 130,
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
                      index: index,
                      homeViewModel: homeViewModel,
                      userInfo: userInfo,
                      petProfileInfo: petProfileInfo,
                    )),
          );
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("${(index + 1).toString()}.",
              //     style: const TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(height: 15),
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
                        // const SizedBox(height: 10),
                        Text("น้ำหนัก: ${petProfileInfo.petWeight} Kg",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black)),
                      ],
                    ),
              // const SizedBox(height: 10),
              Text("เลข factor: ${petProfileInfo.petFactorNumber.toString()}",
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              // Text(
              //     "update ข้อมูลล่าสุดเมื่อ: ${petProfileInfo.updateRecent.toString()}",
              //     style: const TextStyle(fontSize: 16, color: Colors.black)),
              const Text("แก้ไขข้อมูลล่าสุดเมื่อ: 2 วันที่แล้ว",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
