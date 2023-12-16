import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/constants/pet_activity_enum.dart';
import 'package:untitled1/constants/pet_age_enum.dart';
import 'package:untitled1/hive_models/pet_profile_model.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/normal/home/home_view.dart';
import 'package:untitled1/modules/normal/pet_profile/pet_profile_view_model.dart';
import 'package:untitled1/modules/normal/select_ingredient/select_ingredient_view.dart';
import 'package:untitled1/modules/normal/update_pet_profile/update_pet_profile_view.dart';
import 'package:untitled1/widgets/background.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/widgets/delete_confirm_popup.dart';
import 'package:untitled1/widgets/success_popup.dart';

class PetProfileView extends StatefulWidget {
  final PetProfileModel petProfileInfo;
  final UserInfoModel userInfo;
  final bool isJustUpdate;

  const PetProfileView(
      {required this.petProfileInfo,
      required this.userInfo,
      required this.isJustUpdate,
      Key? key})
      : super(key: key);

  @override
  State<PetProfileView> createState() => _PetProfileViewState();
}

class _PetProfileViewState extends State<PetProfileView> {
  late double _petFactorNumber;
  late double _petWeight;
  late String _petType;
  late String _petActivityType;
  late String _petName;
  late String _factorType;
  late String _petPhysiologyStatus;
  late String _petNeuteringStatus;
  late String _petAgeType;
  late List<String> _petChronicDisease;
  late PetProfileViewModel _viewModel;

  final double _labelTextSize = 18.5;
  final double _blockSize = 40;

  @override
  void initState() {
    super.initState();
    _viewModel = PetProfileViewModel();
    _petName = widget.petProfileInfo.petName;
    _petType = widget.petProfileInfo.petType;
    _petPhysiologyStatus = widget.petProfileInfo.petPhysiologyStatus;
    _petNeuteringStatus = widget.petProfileInfo.petNeuteringStatus;
    _petAgeType = widget.petProfileInfo.petAgeType;
    _factorType = widget.petProfileInfo.factorType;
    _petActivityType = widget.petProfileInfo.petActivityType;
    _petChronicDisease = widget.petProfileInfo.petChronicDisease;
    _petFactorNumber = widget.petProfileInfo.petFactorNumber;
    _petWeight = widget.petProfileInfo.petWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded, color: primary),
          onPressed: () {
            widget.isJustUpdate
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeView(userInfo: widget.userInfo)),
                  )
                : Navigator.of(context).pop();
          },
        ),
        title: Center(
            child: Text(
          "ข้อมูลสัตว์เลี้ยง      ",
          style: TextStyle(color: primary, fontWeight: FontWeight.bold),
        )),
        backgroundColor: const Color.fromRGBO(194, 190, 241, 0.4),
      ),
      body: Stack(
        children: [
          const BackGround(
            topColor: Color.fromRGBO(194, 190, 241, 0.4),
            bottomColor: Color.fromRGBO(72, 70, 109, 0.1),
          ),
          SingleChildScrollView(
            child: _content(context),
          ),
        ],
      ),
    );
  }

  Padding _content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _operationButton(),
            ],
          ),
          const SizedBox(height: 15),
          _petNameField(),
          _petTypeField(),
          _petWeightField(),
          _factorTypeField(),
          _factorType == "factorType"
              ? const SizedBox()
              : _factorType == "customize"
                  ? _factorNumberField()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _neuteredField(),
                        _petNeuteringStatus == "-1"
                            ? const SizedBox()
                            : _petAgeField(),
                        _petAgeType == "-1"
                            ? const SizedBox()
                            : _physiologyStatusField(),
                        _petPhysiologyStatus == "ป่วยหรือมีโรคประจำตัว"
                            ? _petChronicDiseaseType()
                            : const SizedBox(),
                        (_petPhysiologyStatus == "ป่วยหรือมีโรคประจำตัว" &&
                                    _petChronicDisease.isNotEmpty) ||
                                (_petPhysiologyStatus !=
                                        "ป่วยหรือมีโรคประจำตัว" &&
                                    _petPhysiologyStatus != "-1")
                            ? _petActivityLevelField()
                            : const SizedBox(),
                      ],
                    ),
          (_factorType == "customize" && _petFactorNumber != -1)
              ? const SizedBox(height: 300)
              : const SizedBox(),
          const SizedBox(height: 40),
          (_petPhysiologyStatus == "ป่วยหรือมีโรคประจำตัว" &&
                  _petChronicDisease.isNotEmpty)
              ? const SizedBox()
              : const SizedBox(height: 160),
          (_factorType == "customize" && _petFactorNumber != -1) ||
                  (_factorType == "recommend" && _petActivityType != "-1")
              ? _searchFoodRecipeButton(context)
              : const SizedBox(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Row _operationButton() {
    return Row(
      children: [
        _editPetProfileButton(),
        const SizedBox(width: 15),
        _deletePetProfileButton(),
      ],
    );
  }

  Future<http.Response> onUserDeletePetProfile({required String petId}) async {
    return _viewModel.onUserDeletePetProfile(petID: petId);
  }

  Widget _deletePetProfileButton() {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: () async {
          DeleteConfirmPopup(
              context: context,
              cancelText: "ยืนยันการลบข้อมูลสัตว์เลี้ยง",
              callback: () {
                Navigator.of(context).pop();
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      onUserDeletePetProfile(
                          petId: widget.petProfileInfo.petID);
                      return FutureBuilder<http.Response>(
                        future: onUserDeletePetProfile(
                            petId: widget.petProfileInfo.petID),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            Future.delayed(const Duration(milliseconds: 1800),
                                () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeView(userInfo: widget.userInfo)),
                              );
                            });
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              SuccessPopup(
                                      context: context,
                                      successText:
                                          'ลบข้อมูลสัตว์เลี้ยงสำเร็จ!!')
                                  .show();
                            });
                            return const SizedBox();
                          }
                        },
                      );
                    });
              }).show();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: red,
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

  Widget _editPetProfileButton() {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdatePetProfileView(
                      userInfo: widget.userInfo,
                      isCreate: false,
                      petProfileInfo: widget.petProfileInfo,
                    )),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: const Color.fromRGBO(137, 207, 223, 1),
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

  SizedBox _searchFoodRecipeButton(BuildContext context) {
    return SizedBox(
      width: 450,
      height: 55,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectIngredientView(),
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text('ค้นหาสูตรอาหาร', style: TextStyle(fontSize: 17)),
      ),
    );
  }

  Widget _petChronicDiseaseType() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "โรคประจำตัว",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            _petChronicDisease.map((item) => ' \u2022 $item').join('\n'),
            maxLines: 100,
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
  }

  Widget _physiologyStatusField() {
    return SizedBox(
      height: _blockSize,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "สถานะทางสรีระ: ",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            _petPhysiologyStatus,
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
  }

  Widget _petAgeField() {
    return SizedBox(
      height: _blockSize,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "อายุ: ",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            getPetAgeTypeName(petAgeType: _petAgeType),
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
  }

  Widget _neuteredField() {
    return SizedBox(
      height: _blockSize,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "การทำหมัน: ",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            _petNeuteringStatus,
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("การทำหมัน", style: TextStyle(fontSize: _labelTextSize)),
        RadioListTile(
          title: const Text("ทำหมัน"),
          groupValue: _petNeuteringStatus,
          onChanged: (value) {
            setState(() {
              _petNeuteringStatus = value!;
            });
          },
          activeColor: Colors.black,
          value: "neutered",
        ),
        RadioListTile(
          title: const Text("ไม่ทำหมัน"),
          groupValue: _petNeuteringStatus,
          onChanged: (value) {
            setState(() {
              _petNeuteringStatus = value!;
            });
          },
          activeColor: Colors.black,
          value: "unneutered",
        ),
      ],
    );
  }

  Widget _petActivityLevelField() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "กิจกรรมต่อวัน",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            " - ${getActivityLevelName(_petActivityType)}",
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
  }

  Widget _petWeightField() {
    return SizedBox(
      height: _blockSize,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "น้ำหนัก (BW) Kg: ",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            _petWeight.toString(),
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
  }

  Widget _factorNumberField() {
    return SizedBox(
      height: _blockSize,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "เลข factor: ",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            _petFactorNumber.toString(),
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
  }

  Widget _factorTypeField() {
    return SizedBox(
      height: _blockSize,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "เลือกใช้ factor: ",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            _factorType,
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("เลือกใช้ factor", style: TextStyle(fontSize: _labelTextSize)),
        RadioListTile(
          selected: _factorType == "recommend" ? true : false,
          title: const Text("ระบบแนะนำ"),
          groupValue: _factorType,
          onChanged: (value) {
            setState(() {
              _factorType = value!;
            });
          },
          activeColor: Colors.black,
          value: "recommend",
        ),
        RadioListTile(
          selected: true,
          title: const Text("กำหนดเอง (สำหรับผู้เชี่ยวชาญ)"),
          groupValue: _factorType,
          onChanged: (value) {
            setState(() {
              _factorType = value!;
            });
          },
          activeColor: Colors.black,
          value: "customize",
        ),
      ],
    );
  }

  Widget _petTypeField() {
    return SizedBox(
      height: _blockSize,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "ชนิดสัตว์เลี้ยง: ",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            _petType,
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
  }

  Widget _petNameField() {
    return SizedBox(
      height: _blockSize,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "ชื่อสัตว์เลี้ยง: ",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            _petName,
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
  }
}
