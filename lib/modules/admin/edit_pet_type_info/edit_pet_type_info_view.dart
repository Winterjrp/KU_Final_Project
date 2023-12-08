import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/add_pet_chronic_disease/add_pet_chronic_disease_view.dart';
import 'package:untitled1/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/modules/admin/edit_pet_type_info/edit_pet_type_info_view_model.dart';
import 'package:untitled1/modules/admin/edit_pet_type_info/widgets/edit_pet_type_info_cancel_popup.dart';
import 'package:untitled1/modules/admin/edit_pet_type_info/widgets/edit_pet_type_info_card.dart';
import 'package:untitled1/modules/admin/edit_pet_type_info/widgets/edit_pet_type_info_confirm_popup.dart';
import 'package:untitled1/widgets/user_profile_app_bar.dart';
import 'package:untitled1/widgets/bottom_navigation_bar.dart';

class EditPetTypeInfoView extends StatefulWidget {
  final UserInfoModel userInfo;
  final PetTypeInfoModel petTypeInfo;
  const EditPetTypeInfoView(
      {required this.userInfo, required this.petTypeInfo, Key? key})
      : super(key: key);

  @override
  State<EditPetTypeInfoView> createState() => _EditPetTypeInfoViewState();
}

class _EditPetTypeInfoViewState extends State<EditPetTypeInfoView> {
  late double height;
  late EditPetTypeInfoViewModel _viewModel;
  late TextEditingController _petTypeNameController;
  // late String _petTypeName;

  @override
  void initState() {
    super.initState();
    _viewModel = EditPetTypeInfoViewModel();
    _petTypeNameController = TextEditingController();
    _petTypeNameController.text = widget.petTypeInfo.petTypeName;
    _viewModel.petChronicDiseaseList = widget.petTypeInfo.petChronicDisease;
    // _petTypeName = '';
    // _viewModel.getHomeData(userID: widget.userInfo.userID);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return WillPopScope(
        onWillPop: () async {
          bool confirm = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return const EditPetTypeInfoCancelPopup();
              });
          return confirm;
        },
        child: Scaffold(
            bottomNavigationBar:
                ProjectNavigationBar(index: 0, userInfo: widget.userInfo),
            body: SafeArea(
                child: Column(
              children: [
                UserProfileAppBar(
                  userInfo: widget.userInfo,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        _header(),
                        const SizedBox(height: 5),
                        _petTypeNamePart(),
                        const SizedBox(height: 15),
                        Expanded(
                          child: Column(
                            children: [
                              _petTypeInfo(height: height, context: context),
                              const SizedBox(height: 15),
                              _addPetChronicDiseaseButton(),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        _acceptButton(context),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ],
            ))));
  }

  Widget _header() {
    return const SizedBox(
      child: Text(
        "แก้ไขข้อมูลชนิดสัตว์เลี้ยง",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 42,
          // color: kPrimaryDarkColor,
        ),
      ),
    );
  }

  Widget _petTypeNamePart() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      width: 500,
      child: TextField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        controller: _petTypeNameController,
        style: const TextStyle(fontSize: 17),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: "ชนิดสัตว์เลี้ยง",
          labelStyle: const TextStyle(fontSize: 19),
          contentPadding: const EdgeInsets.only(left: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: tGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: tGrey),
          ),
        ),
        onChanged: (value) {
          // _petTypeName = value;
          // setState(() {});
        },
      ),
    );
  }

  Widget _petTypeInfo({required double height, required BuildContext context}) {
    return SingleChildScrollView(
        child: Container(
      constraints: BoxConstraints(maxHeight: height * 0.72),
      height: 75.0 * _viewModel.petChronicDiseaseList.length,
      child: ListView.builder(
        itemCount: _viewModel.petChronicDiseaseList.length,
        itemBuilder: (context, index) {
          return EditPetTypeInfoCard(
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

  void onUserAddPetChronicDiseaseCallBack(
      {required List<NutrientLimitInfoModel> nutrientLimitInfo,
      required String petChronicDiseaseID,
      required String petChronicDiseaseName}) async {
    setState(() {});
    _viewModel.onUserAddPetChronicDisease(
        nutrientLimitInfo: nutrientLimitInfo,
        petChronicDiseaseID: petChronicDiseaseID,
        petChronicDiseaseName: petChronicDiseaseName);
  }

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

  Widget _addPetChronicDiseaseButton() {
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
                      builder: (context) => AddPetChronicDiseaseView(
                          userInfo: widget.userInfo,
                          addPetChronicDiseaseCallBack:
                              onUserAddPetChronicDiseaseCallBack,
                          petTypeName: _petTypeNameController.text)),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 50),
                  Text(
                    " เพิ่มข้อมูลโรคประจำตัวสัตว์เลี้ยง",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Row _acceptButton(BuildContext context) {
    Future<void> onUserEditPetTypeInfoCallBack(
        {required String petTypeID, required String petTypeName}) async {
      _viewModel.onUserEditPetTypeInfo(
          petTypeID: petTypeID, petTypeName: petTypeName);
    }

    return Row(
      children: [
        const Spacer(),
        SizedBox(
          height: 60,
          width: 200,
          child: ElevatedButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return EditPetTypeInfoConfirmPopup(
                      userInfo: widget.userInfo,
                      petTypeName: _petTypeNameController.text,
                      onUserAddPetTypeInfoCallBack:
                          onUserEditPetTypeInfoCallBack,
                      petTypeInfo: widget.petTypeInfo);
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(58, 180, 106, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('ตกลง', style: TextStyle(fontSize: 17)),
          ),
        ),
      ],
    );
  }
}
