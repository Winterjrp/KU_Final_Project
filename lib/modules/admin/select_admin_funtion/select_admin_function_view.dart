import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/add_recipes/add_recipe_view.dart';
import 'package:untitled1/modules/admin/ingredient_management/ingredient_management_view.dart';
import 'package:untitled1/modules/admin/pet_type_info_management/pet_type_info_management_view.dart';
import 'package:untitled1/modules/admin/recipes_management/recipes_management_view.dart';
import 'package:untitled1/modules/admin/user_management/user_management_view.dart';
import 'package:untitled1/widgets/bottom_navigation_bar.dart';

class SelectAdminFunctionView extends StatelessWidget {
  const SelectAdminFunctionView({required this.userInfo, Key? key})
      : super(key: key);

  final UserInfoModel userInfo;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("ฟังก์ชันสำหรับผู้ดูแลระบบ")),
          backgroundColor: primary,
        ),
        bottomNavigationBar: ProjectNavigationBar(index: 2, userInfo: userInfo),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Text(
              //       "ตั้งค่าการใช้งาน",
              //       style: TextStyle(
              //           fontSize: 28, fontWeight: FontWeight.bold),
              //     ),
              //     Text("หมายเลขผู้ใช้งาน: ${userInfo.userID}",
              //         style: const TextStyle(
              //           fontSize: 17,
              //         )),
              //   ],
              // ),
              // const SizedBox(height: 30),
              Column(
                children: [
                  userInfo.userRole.isUserManagementAdmin
                      ? _userManagement(context)
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  userInfo.userRole.isPetFoodManagementAdmin
                      ? _ingredientManagement(context)
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  userInfo.userRole.isPetFoodManagementAdmin
                      ? _recipesManagement(context)
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  userInfo.userRole.isPetFoodManagementAdmin
                      ? _petTypeManagement(context)
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  userInfo.userRole.isPetFoodManagementAdmin
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             IngredientManagementView(
                                //                 userInfo: userInfo)));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(217, 217, 217, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('จัดการสูตรคำนวณสารอาหาร',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black)),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _petTypeManagement(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PetTypeInfoManagementView(
                          userInfo: userInfo,
                        )));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('จัดการชนิดสัตว์เลี้ยง',
              style: TextStyle(fontSize: 17, color: Colors.black)),
        ),
      ),
    );
  }

  Container _recipesManagement(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RecipesManagementView(userInfo: userInfo)));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('จัดการสูตรอาหาร',
              style: TextStyle(fontSize: 17, color: Colors.black)),
        ),
      ),
    );
  }

  Container _ingredientManagement(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IngredientManagementView(
                          userInfo: userInfo,
                        )));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('จัดการวัตถุดิบ',
              style: TextStyle(fontSize: 17, color: Colors.black)),
        ),
      ),
    );
  }

  Container _userManagement(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserManagementView()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('จัดการผู้ใช้งาน',
              style: TextStyle(fontSize: 17, color: Colors.black)),
        ),
      ),
    );
  }

  // Widget _loadingScreen() {
  //   return const Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         CircularProgressIndicator(
  //           strokeWidth: 3.5,
  //         ),
  //         SizedBox(
  //           height: 30,
  //         ),
  //         Text(
  //           "กำลังโหลดข้อมูล กรุณารอสักครู่...",
  //           style: TextStyle(fontSize: 20),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
