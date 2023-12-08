import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/constants/color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:untitled1/hive_models/pet_profile_model.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/normal/home/home_view.dart';
import 'package:untitled1/modules/normal/home/home_view_model.dart';
import 'package:untitled1/modules/normal/pet_profile/pet_profile_view.dart';
import 'package:untitled1/modules/normal/update_pet_profile/update_pet_profile_view_model.dart';
import 'package:untitled1/modules/normal/update_pet_profile/widgets/update_pet_profile_confirm_popup.dart';
import 'package:untitled1/widgets/cancel_popup.dart';
import 'package:untitled1/widgets/background.dart';
import 'package:http/http.dart' as http;

class UpdatePetProfileView extends StatefulWidget {
  final PetProfileModel petProfileInfo;
  final UserInfoModel userInfo;
  final bool isCreate;
  final HomeViewModel homeViewModel;
  final int index;
  const UpdatePetProfileView(
      {required this.userInfo,
      required this.isCreate,
      required this.petProfileInfo,
      required this.homeViewModel,
      required this.index,
      Key? key})
      : super(key: key);

  @override
  State<UpdatePetProfileView> createState() => _UpdatePetProfileViewState();
}

class _UpdatePetProfileViewState extends State<UpdatePetProfileView> {
  late double _petFactorNumber;
  late double _petWeight;
  late List<String> _petChronicDiseaseList;
  late List<String> _petTypeList;
  late List<String> _physiologyStatusList;
  late List<String> _petChronicDisease;
  late String _petType;
  late String _petActivityType;
  late String _petName;
  late String _factorType;
  late String _petPhysiologyStatus;
  late String _petNeuteringStatus;
  late String _petAgeType;
  late String _petID;
  late bool _isEnable;
  late AddPetProfileViewModel _viewModel;
  late TextEditingController _petNameController;
  late TextEditingController _petFactorNumberController;
  late TextEditingController _petWeightController;

  final double _labelTextSize = 19;
  final double _inputTextSize = 17;
  final ScrollController _controller = ScrollController();
  final _petChronicDiseaseKey = GlobalKey<DropdownSearchState<String>>();

  @override
  void initState() {
    super.initState();
    _petNameController = TextEditingController();
    _petFactorNumberController = TextEditingController();
    _petWeightController = TextEditingController();
    _viewModel = AddPetProfileViewModel();
    _petTypeList = [
      "สุนัข",
      "แมว",
      "มด",
      'ม้า',
    ];
    _petChronicDiseaseList = ["โรคเบาหวาน", "โรคความดัน", "โรคตับ", "โรคไต"];
    _physiologyStatusList = [
      "สุขภาพดี",
      "ตั้งท้อง",
      "ให้นมลูก",
      "ป่วยหรือมีโรคประจำตัว"
    ];
    if (widget.isCreate) {
      _petName = "-1";
      _petType = "-1";
      _petPhysiologyStatus = "-1";
      _petNeuteringStatus = "-1";
      _petAgeType = "-1";
      _factorType = "factorType";
      _petActivityType = "-1";
      _petChronicDisease = [];
      _petFactorNumber = -1;
      _petWeight = -1;
      _petID = Random().nextInt(999).toString();
    } else {
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
      _petID = widget.petProfileInfo.petID;
      _petNameController.text = _petName;
      _petWeightController.text = _petWeight.toString();
      _petFactorNumberController.text = _petFactorNumber.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    _isEnable = true;
    if (_petName == "-1" ||
        _petName == "" ||
        _petType == "-1" ||
        _factorType == "factorType") {
      _isEnable = false;
    }
    if (_factorType == "customize" && _petFactorNumber == -1 ||
        _petFactorNumber == -2) {
      _isEnable = false;
    }
    if (_factorType == "recommend" &&
        (_petWeight == -1 ||
            _petWeight == -2 ||
            _petNeuteringStatus == "-1" ||
            _petAgeType == "-1" ||
            _petPhysiologyStatus == "-1" ||
            _petActivityType == "-1")) {
      _isEnable = false;
    }
    if (_factorType == "recommend" &&
        _petPhysiologyStatus == "ป่วยหรือมีโรคประจำตัว" &&
        _petChronicDisease.isEmpty) {
      _isEnable = false;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded, color: red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return widget.isCreate
                    ? const CancelPopup(
                        cancelText: 'ยกเลิกการเพิ่มข้อมูลสัตว์เลี้ยง?',
                      )
                    : const CancelPopup(
                        cancelText: 'ยกเลิกการแก้ไขข้อมูลสัตว์เลี้ยง?',
                      );
              },
            );
          },
        ),
        title: Center(
            child: Text(
          widget.isCreate
              ? "เพิ่มข้อมูลสัตว์เลี้ยง    "
              : "แก้ไขข้อมูลสัตว์เลี้ยง    ",
          style: TextStyle(color: red),
        )),
        backgroundColor: const Color.fromRGBO(222, 150, 154, 0.8),
      ),
      body: Stack(
        children: [
          const BackGround(
              topColor: Color.fromRGBO(222, 150, 154, 0.8),
              bottomColor: Color.fromRGBO(241, 165, 165, 0.6)),
          SingleChildScrollView(
            controller: _controller,
            child: _content(context),
          ),
        ],
      ),
    );
  }

  Padding _content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 10),
          _petNameField(),
          const SizedBox(height: 25),
          _petName == "-1" ? const SizedBox() : _petTypeField(),
          const SizedBox(height: 20),
          _petType == "-1" ? const SizedBox() : _factorTypeField(),
          const SizedBox(height: 5),
          _factorType == "factorType"
              ? const SizedBox()
              : _factorType == "customize"
                  ? _petFactorNumberField()
                  : Column(
                      children: [
                        _petWeightField(),
                        const SizedBox(height: 20),
                        _petWeight == -1 ? const SizedBox() : _neuteredField(),
                        const SizedBox(height: 15),
                        _petNeuteringStatus == "-1"
                            ? const SizedBox()
                            : _petAgeField(),
                        const SizedBox(height: 20),
                        _petAgeType == "-1"
                            ? const SizedBox()
                            : _physiologyStatusField(),
                        const SizedBox(height: 20),
                        _petPhysiologyStatus == "ป่วยหรือมีโรคประจำตัว"
                            ? _petChronicDiseaseType()
                            : const SizedBox(),
                        const SizedBox(height: 10),
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
          const SizedBox(height: 50),
          (_factorType == "customize" && _petFactorNumber != -1) ||
                  (_factorType == "recommend" && _petActivityType != "-1")
              ? _acceptButton(context)
              : const SizedBox(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Future<http.Response> onUserAddPetProfileCallback() async {
    return await _viewModel.onUserAddPetProfile(
        petID: _petID,
        petName: _petName,
        petType: _petType,
        factorType: _factorType,
        petFactorNumber: _petFactorNumber,
        petWeight: _petWeight,
        petNeuteringStatus: _petNeuteringStatus,
        petAgeType: _petAgeType,
        petPhysiologyStatus: _petPhysiologyStatus,
        petChronicDisease: _petChronicDisease,
        petActivityType: _petActivityType);
  }

  Future<http.Response> onUserEditPetProfileCallback() async {
    return await _viewModel.onUserEditPetProfile(
        petID: _petID,
        petName: _petName,
        petType: _petType,
        factorType: _factorType,
        petFactorNumber: _petFactorNumber,
        petWeight: _petWeight,
        petNeuteringStatus: _petNeuteringStatus,
        petAgeType: _petAgeType,
        petPhysiologyStatus: _petPhysiologyStatus,
        petChronicDisease: _petChronicDisease,
        petActivityType: _petActivityType);
  }

  Future<void> fetchHomeData(BuildContext context) async {
    widget.homeViewModel.getHomeData(userID: widget.userInfo.userID);
  }

  SizedBox _acceptButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () async {
          _isEnable
              ? showDialog(
                  context: context,
                  builder: (context) {
                    return widget.isCreate
                        ? UpdatePetProfileConfirmPopup(
                            userInfo: widget.userInfo,
                            callBack: onUserAddPetProfileCallback,
                            updateInfoText: 'ยืนยันการเพิ่มข้อมูลสัตว์เลี้ยง?',
                            routing: () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeView(userInfo: widget.userInfo)),
                              );
                            },
                          )
                        : UpdatePetProfileConfirmPopup(
                            userInfo: widget.userInfo,
                            callBack: onUserEditPetProfileCallback,
                            updateInfoText: 'ยืนยันการแก้ไขข้อมูลสัตว์เลี้ยง?',
                            routing: () async {
                              // onUserEditPetProfileCallback();
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return FutureBuilder<http.Response>(
                                      future: onUserEditPetProfileCallback(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'),
                                          );
                                        } else {
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 2000), () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PetProfileView(
                                                  userInfo: widget.userInfo,
                                                  petProfileInfo: PetProfileModel(
                                                      petID: _petID,
                                                      petName: _petName,
                                                      petType: _petType,
                                                      factorType: _factorType,
                                                      petFactorNumber:
                                                          _petFactorNumber,
                                                      petWeight: _petWeight,
                                                      petNeuteringStatus:
                                                          _petNeuteringStatus,
                                                      petAgeType: _petAgeType,
                                                      petPhysiologyStatus:
                                                          _petPhysiologyStatus,
                                                      petChronicDisease:
                                                          _petChronicDisease,
                                                      petActivityType:
                                                          _petActivityType,
                                                      updateRecent: ''),
                                                  homeViewModel:
                                                      widget.homeViewModel,
                                                  index: widget.index,
                                                ),
                                              ),
                                            );
                                          });
                                          return const Center(
                                            child: Text('Response: yeahhh'),
                                          );
                                        }
                                      },
                                    );
                                  });

                              // onUserEditPetProfileCallback();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => PetProfileView(
                              //       userInfo: widget.userInfo,
                              //       petProfileInfo: PetProfileModel(
                              //           petID: _petID,
                              //           petName: _petName,
                              //           petType: _petType,
                              //           factorType: _factorType,
                              //           petFactorNumber: _petFactorNumber,
                              //           petWeight: _petWeight,
                              //           petNeuteringStatus: _petNeuteringStatus,
                              //           petAgeType: _petAgeType,
                              //           petPhysiologyStatus:
                              //               _petPhysiologyStatus,
                              //           petChronicDisease: _petChronicDisease,
                              //           petActivityType: _petActivityType,
                              //           updateRecent: ''),
                              //       homeViewModel: widget.homeViewModel,
                              //       index: widget.index,
                              //     ),
                              //   ),
                              // );

                              // onUserEditPetProfileCallback().then((_) => {
                              //       widget.homeViewModel
                              //           .getHomeData(
                              //               userID: widget.userInfo.userID)
                              //           .then((HomeModel homeData) {
                              //         Navigator.of(context)
                              //             .popUntil((route) => route.isFirst);
                              //         Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) => PetProfileView(
                              //               userInfo: widget.userInfo,
                              //               petProfileInfo: PetProfileModel(
                              //                   petID: _petID,
                              //                   petName: _petName,
                              //                   petType: _petType,
                              //                   factorType: _factorType,
                              //                   petFactorNumber:
                              //                       _petFactorNumber,
                              //                   petWeight: _petWeight,
                              //                   petNeuteringStatus:
                              //                       _petNeuteringStatus,
                              //                   petAgeType: _petAgeType,
                              //                   petPhysiologyStatus:
                              //                       _petPhysiologyStatus,
                              //                   petChronicDisease:
                              //                       _petChronicDisease,
                              //                   petActivityType:
                              //                       _petActivityType,
                              //                   updateRecent: ''),
                              //               homeViewModel: widget.homeViewModel,
                              //               index: widget.index,
                              //             ),
                              //           ),
                              //         );
                              //       })
                              //     });
                            },
                          );
                  },
                )
              : null;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isEnable ? red : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text('ตกลง',
            style: TextStyle(fontSize: 17, color: Colors.white)),
      ),
    );
  }

  DropdownSearch<String> _petChronicDiseaseType() {
    return DropdownSearch<String>.multiSelection(
      selectedItems: widget.isCreate ? [] : _petChronicDisease,
      key: _petChronicDiseaseKey,
      popupProps: PopupPropsMultiSelection.dialog(
        selectionWidget: (BuildContext context, String temp, bool isCheck) {
          return Checkbox(
            activeColor: const Color.fromRGBO(202, 102, 108, 1),
            value: isCheck,
            onChanged: (bool? value) {},
          );
        },
        dialogProps: DialogProps(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
            contentPadding: const EdgeInsets.all(5),
            backgroundColor: const Color.fromRGBO(254, 245, 245, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        validationWidgetBuilder: (ctx, selectedItems) {
          return Container(
            height: 80,
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(right: 5, bottom: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _petChronicDiseaseKey.currentState?.popupOnValidate();
              },
            ),
          );
        },
        itemBuilder: (BuildContext context, String item, bool isSelect) {
          return Row(
            children: [
              const SizedBox(width: 10),
              Text(
                item,
                style: TextStyle(
                    fontSize: 16,
                    color: isSelect
                        ? const Color.fromRGBO(202, 102, 108, 1)
                        : Colors.black),
              ),
            ],
          );
        },
        showSearchBox: true,
        showSelectedItems: true,
        searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            height: 0.9,
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(Icons.search),
          labelText: "ค้นหาโรคประจำตัว",
          labelStyle: const TextStyle(fontSize: 16, height: 1),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        )),
      ),
      dropdownBuilder: (BuildContext context, List<String> selectedItems) {
        if (selectedItems.isEmpty) {
          return const SizedBox();
        }

        return Wrap(
          children: selectedItems.map((e) {
            return Container(
                margin: const EdgeInsets.only(right: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(202, 102, 108, 1),
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: IntrinsicWidth(
                  child: Row(
                    children: [
                      Text(
                        e,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Transform.scale(
                        scale: 1.8,
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: IconButton(
                            onPressed: () {
                              setState(() {});
                              selectedItems.remove(e);
                              _petChronicDisease = selectedItems;
                            },
                            icon: const Icon(Icons.close),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            iconSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          }).toList(),
        );
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          height: 0.9,
        ),
        fillColor: Colors.white,
        filled: true,
        labelText: "โรคประจำตัว",
        labelStyle: TextStyle(fontSize: _labelTextSize, height: 1),
        contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 40),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      )),
      items: _petChronicDiseaseList,
      onChanged: (value) {
        setState(() {
          _petChronicDisease = value;
        });
        _controller.animateTo(
          1000.0,
          duration: const Duration(seconds: 1),
          curve: Curves.ease,
        );
      },
    );
  }

  Widget _physiologyStatusField() {
    return SizedBox(
      height: 65,
      child: DropdownSearch<String>(
        selectedItem: widget.isCreate ? "" : _petPhysiologyStatus,
        popupProps: PopupProps.menu(
          itemBuilder: (BuildContext context, String item, bool isSelect) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item != _petPhysiologyStatus
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: 16,
                                color: item == _petPhysiologyStatus
                                    ? const Color.fromRGBO(202, 102, 108, 1)
                                    : Colors.black),
                          ),
                        )
                      : Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: item == _petPhysiologyStatus
                                        ? const Color.fromRGBO(202, 102, 108, 1)
                                        : Colors.black),
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.pets,
                                color: Color.fromRGBO(202, 102, 108, 1))
                          ],
                        ),
                ],
              ),
            );
          },
          menuProps: MenuProps(
              backgroundColor: const Color.fromRGBO(254, 245, 245, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(fontSize: _inputTextSize),
            dropdownSearchDecoration: InputDecoration(
              floatingLabelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                height: 0.9,
              ),
              fillColor: Colors.white,
              filled: true,
              labelText: "สถานะทางสรีระ",
              labelStyle: TextStyle(fontSize: _labelTextSize),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
            )),
        items: _physiologyStatusList,
        onChanged: (value) {
          setState(() {
            _petPhysiologyStatus = value!;
          });
          _controller.animateTo(
            1000.0,
            duration: const Duration(seconds: 1),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  Column _petAgeField() {
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
            _controller.animateTo(
              1000.0,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
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
            _controller.animateTo(
              1000.0,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
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
            _controller.animateTo(
              1000.0,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
          },
          activeColor: Colors.black,
          value: "old",
        ),
      ],
    );
  }

  Column _neuteredField() {
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
            _controller.animateTo(
              1000.0,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
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
            _controller.animateTo(
              1000.0,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
          },
          activeColor: Colors.black,
          value: "unneutered",
        ),
      ],
    );
  }

  Column _petActivityLevelField() {
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
            _controller.animateTo(
              1000.0,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
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
            _controller.animateTo(
              1000.0,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
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
            _controller.animateTo(
              1000.0,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
          },
          activeColor: Colors.black,
          value: "veryActive",
        ),
      ],
    );
  }

  Container _petWeightField() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 65,
      child: TextField(
        onTap: () {
          _petWeightController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _petWeightController.text.length,
          );
        },
        controller: _petWeightController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
        ],
        style: TextStyle(fontSize: _inputTextSize),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            height: 0.9,
          ),
          fillColor: Colors.white,
          filled: true,
          labelText: "น้ำหนัก (BW) Kg",
          labelStyle: TextStyle(fontSize: _labelTextSize),
          suffixText: "Kg   ",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
        onChanged: (value) {
          setState(() {
            if (value == "") {
              _petWeight = -2;
            } else {
              _petWeight = double.parse(value);
            }
          });
        },
      ),
    );
  }

  Container _petFactorNumberField() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 60,
      child: TextField(
        onTap: () {
          _petFactorNumberController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _petFactorNumberController.text.length,
          );
        },
        controller: _petFactorNumberController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
        ],
        style: TextStyle(fontSize: _inputTextSize),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            height: 0.9,
          ),
          fillColor: Colors.white,
          filled: true,
          labelText: "เลข factor",
          labelStyle: TextStyle(fontSize: _labelTextSize),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
        onChanged: (value) {
          setState(() {
            if (value == "") {
              _petFactorNumber = -2;
            } else {
              _petFactorNumber = double.parse(value);
            }
          });
        },
      ),
    );
  }

  Column _factorTypeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("เลือกใช้ factor", style: TextStyle(fontSize: _labelTextSize)),
        RadioListTile(
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

  Container _petTypeField() {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 8),
      child: DropdownSearch<String>(
        selectedItem: widget.isCreate ? "" : _petType,
        popupProps: PopupProps.menu(
          itemBuilder: (BuildContext context, String item, bool isSelect) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item != _petType
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: 16,
                                color: item == _petType
                                    ? const Color.fromRGBO(202, 102, 108, 1)
                                    : Colors.black),
                          ),
                        )
                      : Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: item == _petPhysiologyStatus
                                        ? const Color.fromRGBO(202, 102, 108, 1)
                                        : Colors.black),
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.pets,
                                color: Color.fromRGBO(202, 102, 108, 1))
                          ],
                        ),
                ],
              ),
            );
          },
          menuProps: MenuProps(
              backgroundColor: const Color.fromRGBO(254, 245, 245, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          showSearchBox: true,
          showSelectedItems: true,
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
            floatingLabelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              height: 0.9,
            ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: const Icon(Icons.search),
            labelText: "ค้นหาชนิดสัตว์เลี้ยง",
            labelStyle: const TextStyle(fontSize: 16),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black, width: 1.8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black, width: 1.8),
            ),
          )),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(fontSize: _inputTextSize),
            dropdownSearchDecoration: InputDecoration(
              floatingLabelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                height: 0.9,
              ),
              fillColor: Colors.white,
              filled: true,
              labelText: "ชนิดสัตว์เลี้ยง",
              labelStyle:
                  TextStyle(fontSize: _labelTextSize, color: Colors.black),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
            )),
        items: _petTypeList,
        onChanged: (value) {
          setState(() {
            _petType = value!;
          });
        },
      ),
    );
  }

  Container _petNameField() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 60,
      width: double.infinity,
      child: TextField(
        onTap: () {
          _petNameController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _petNameController.text.length,
          );
        },
        controller: _petNameController,
        style: TextStyle(fontSize: _inputTextSize, color: Colors.black),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            height: 0.9,
          ),
          fillColor: Colors.white,
          filled: true,
          labelText: "ชื่อสัตว์เลี้ยง",
          labelStyle: TextStyle(fontSize: _labelTextSize),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
        onChanged: (value) {
          setState(() {
            // _petName = "-1";
            _petName = value;
          });
        },
      ),
    );
  }
}
