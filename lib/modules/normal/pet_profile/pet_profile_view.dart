import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/hive_models/pet_profile_model.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/normal/home/home_view_model.dart';
import 'package:untitled1/modules/normal/pet_profile/pet_profile_view_model.dart';
import 'package:untitled1/modules/normal/pet_profile/widgets/delete_pet_profile_confirm_popup.dart';
import 'package:untitled1/modules/normal/select_ingredient/select_ingredient_view.dart';
import 'package:untitled1/modules/normal/update_pet_profile/update_pet_profile_view.dart';
import 'package:untitled1/widgets/background.dart';

class PetProfileView extends StatefulWidget {
  final HomeViewModel homeViewModel;
  final PetProfileModel petProfileInfo;
  final UserInfoModel userInfo;
  final int index;

  const PetProfileView(
      {required this.petProfileInfo,
      required this.userInfo,
      required this.homeViewModel,
      required this.index,
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
  final double _blockSize = 55;

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
      // backgroundColor: const Color.fromRGBO(194, 190, 241, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded, color: primary),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
            child: Text(
          "ข้อมูลสัตว์เลี้ยง      ",
          style: TextStyle(color: primary, fontWeight: FontWeight.bold),
        )),
        backgroundColor: const Color.fromRGBO(194, 190, 241, 0.7),
      ),
      body: Stack(
        children: [
          const BackGround(
            topColor: Color.fromRGBO(194, 190, 241, 0.7),
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
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _operationButton(),
            ],
          ),
          const SizedBox(height: 10),
          _petNameField(),
          _petTypeField(),
          _factorTypeField(),
          _factorType == "factorType"
              ? const SizedBox()
              : _factorType == "customize"
                  ? _factorNumberField()
                  : Column(
                      children: [
                        _petWeightField(),
                        _petWeight == -1 ? const SizedBox() : _neuteredField(),
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
              ? const SizedBox(height: 150)
              : const SizedBox(),
          const SizedBox(height: 20),
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

  Widget _deletePetProfileButton() {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return DeletePetProfileConfirmPopup(
                  petProfileViewModel: _viewModel,
                  // deletePetInfoCallBack: deletePetInfoCallBack,
                  petID: widget.petProfileInfo.petID,
                  userInfo: widget.userInfo);
            },
          );
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
                      homeViewModel: widget.homeViewModel,
                      index: widget.index,
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
          backgroundColor: darkYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text('ค้นหาสูตรอาหาร',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _petChronicDiseaseType() {
    return SizedBox(
      height: _blockSize,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "โรคประจำตัว: ",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            _petChronicDisease.join(', '),
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
            _petAgeType,
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("อายุ", style: TextStyle(fontSize: _labelTextSize)),
        RadioListTile(
          title: const Text("น้อยกว่า 1 ปี"),
          groupValue: _petAgeType,
          onChanged: (value) {
            setState(() {
              _petAgeType = value!;
            });
          },
          activeColor: Colors.black,
          value: "baby",
        ),
        RadioListTile(
          title: const Text("1 - 7 ปี"),
          groupValue: _petAgeType,
          onChanged: (value) {
            setState(() {
              _petAgeType = value!;
            });
          },
          activeColor: Colors.black,
          value: "adult",
        ),
        RadioListTile(
          title: const Text("มากกว่า 7 ปี"),
          groupValue: _petAgeType,
          onChanged: (value) {
            setState(() {
              _petAgeType = value!;
            });
          },
          activeColor: Colors.black,
          value: "old",
        ),
      ],
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
    return SizedBox(
      height: _blockSize,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "กิจกรรมต่อวัน: ",
            style: TextStyle(
                fontSize: _labelTextSize, fontWeight: FontWeight.bold),
          ),
          Text(
            _petActivityType,
            style: TextStyle(fontSize: _labelTextSize),
          )
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("กิจกรรมต่อวัน", style: TextStyle(fontSize: _labelTextSize)),
        RadioListTile(
          title: const Text(
              "อยู่นิ่งๆ เคลื่อนตัวเพื่อไปกินอาหาร/น้ำ, ขับถ่ายหรือออกกำลังกายน้อยกว่า 1 ชม./วัน (Inactive)"),
          groupValue: _petActivityType,
          onChanged: (value) {
            setState(() {
              _petActivityType = value!;
            });
          },
          activeColor: Colors.black,
          value: "Inactive",
        ),
        RadioListTile(
          title: const Text("ออกกำลังกาย 1 - 3 ชม./วัน (Moderate active)"),
          groupValue: _petActivityType,
          onChanged: (value) {
            setState(() {
              _petActivityType = value!;
            });
          },
          activeColor: Colors.black,
          value: "moderateActive",
        ),
        RadioListTile(
          title: const Text("ออกกำลังกายมากกว่า 3 ชม./วัน (Very active)"),
          groupValue: _petActivityType,
          onChanged: (value) {
            setState(() {
              _petActivityType = value!;
            });
          },
          activeColor: Colors.black,
          value: "veryActive",
        ),
      ],
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
