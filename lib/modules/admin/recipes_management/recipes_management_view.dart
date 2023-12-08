import 'package:flutter/material.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/add_recipes/add_recipe_view.dart';
import 'package:untitled1/modules/admin/recipes_management/recipes_management_view_model.dart';
import 'package:untitled1/modules/admin/recipes_management/widgets/recipes_management_card.dart';
import 'package:untitled1/widgets/user_profile_app_bar.dart';
import 'package:untitled1/widgets/bottom_navigation_bar.dart';

class RecipesManagementView extends StatefulWidget {
  const RecipesManagementView({required this.userInfo, Key? key})
      : super(key: key);

  final UserInfoModel userInfo;
  @override
  State<RecipesManagementView> createState() => _RecipesManagementViewState();
}

class _RecipesManagementViewState extends State<RecipesManagementView> {
  late double height;
  late RecipesManagementViewModel _viewModel;
  // late String _petTypeName;

  @override
  void initState() {
    super.initState();
    _viewModel = RecipesManagementViewModel();
    // _petTypeName = '';
    // _viewModel.getHomeData(userID: widget.userInfo.userID);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      bottomNavigationBar:
          ProjectNavigationBar(index: 0, userInfo: widget.userInfo),
      body: SafeArea(
        child: FutureBuilder<List<RecipesModel>>(
            future: _viewModel.recipesListData,
            builder: (context, AsyncSnapshot<List<RecipesModel>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return _loadingScreen();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    UserProfileAppBar(
                      userInfo: widget.userInfo,
                    ),
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
                                children: [
                                  _recipesInfo(
                                      height: height, context: context),
                                  const SizedBox(height: 15),
                                  _addRecipesButton(),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Text('No data available');
            }),
      ),
    );
  }

  Widget _header() {
    return const SizedBox(
      child: Text(
        "จัดการข้อมูลสูตรอาหารสัตว์เลี้ยง",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 42,
          // color: kPrimaryDarkColor,
        ),
      ),
    );
  }

  Widget _recipesInfo({required double height, required BuildContext context}) {
    return SingleChildScrollView(
        child: Container(
      constraints: BoxConstraints(maxHeight: height * 0.72),
      height: 75.0 * _viewModel.recipesList.length,
      child: ListView.builder(
        itemCount: _viewModel.recipesList.length,
        itemBuilder: (context, index) {
          return RecipesManagementCard(
            index: index,
            context: context,
            viewModel: _viewModel,
            userInfo: widget.userInfo,
            // deletePetInfoCallBack: onUserDeleteCallBack
          );
        },
      ),
    ));
  }

  // void onUserAddPetChronicDiseaseCallBack(
  //     {required List<NutrientLimitInfoModel> nutrientLimitInfo,
  //     required String petChronicDiseaseID,
  //     required String petChronicDiseaseName}) async {
  //   setState(() {});
  //   _viewModel.onUserAddPetChronicDisease(
  //       nutrientLimitInfo: nutrientLimitInfo,
  //       petChronicDiseaseID: petChronicDiseaseID,
  //       petChronicDiseaseName: petChronicDiseaseName);
  // }

  Widget _loadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3.5,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "กำลังโหลดข้อมูล กรุณารอสักครู่...",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _addRecipesButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddRecipesView(userInfo: widget.userInfo)));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 50),
                  Text(
                    " เพิ่มข้อมูลสูตรอาหารสัตว์เลี้ยง",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
