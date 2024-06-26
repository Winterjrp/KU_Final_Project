import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/constants/size.dart';
import 'package:untitled1/modules/admin/update_pet_chronic_disease/update_pet_chronic_disease_view.dart';
import 'package:untitled1/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/modules/admin/update_pet_chronic_disease/widgets/nutrient_limit_table_cell.dart';
import 'package:untitled1/modules/admin/pet_type_info/pet_type_info_view.dart';
import 'package:untitled1/modules/admin/pet_type_info_management/pet_type_info_management_view.dart';
import 'package:untitled1/modules/admin/update_pet_type_info/update_pet_type_info_view_model.dart';
import 'package:untitled1/modules/admin/update_pet_type_info/widgets/pet_chronic_disease_table_cell.dart';
import 'package:untitled1/modules/admin/widgets/button/admin_add_object_button.dart';
import 'package:untitled1/modules/admin/widgets/filter_search_bar.dart';
import 'package:untitled1/modules/admin/widgets/loading_screen/admin_loading_screen.dart';
import 'package:untitled1/modules/admin/widgets/loading_screen/admin_loading_screen_with_text.dart';
import 'package:untitled1/modules/admin/widgets/popup/admin_cancel_popup.dart';
import 'package:untitled1/modules/admin/widgets/popup/admin_confirm_popup.dart';
import 'package:untitled1/modules/admin/widgets/popup/admin_error_popup.dart';
import 'package:untitled1/modules/admin/widgets/popup/admin_success_popup.dart';
import 'package:untitled1/modules/admin/widgets/popup/admin_warning_popup.dart';
import 'package:untitled1/utility/navigation_with_animation.dart';

class UpdatePetTypeInfoView extends StatefulWidget {
  final bool isCreate;
  final PetTypeInfoModel petTypeInfo;
  final OnUserDeletePetTypeInfoCallBackFunction onUserDeletePetTypeInfoCallBack;

  const UpdatePetTypeInfoView({
    Key? key,
    required this.isCreate,
    required this.petTypeInfo,
    required this.onUserDeletePetTypeInfoCallBack,
  }) : super(key: key);

  @override
  State<UpdatePetTypeInfoView> createState() => _UpdatePetTypeInfoViewState();
}

class _UpdatePetTypeInfoViewState extends State<UpdatePetTypeInfoView> {
  late UpdatePetTypeInfoViewModel _viewModel;
  late TextEditingController _petTypeNameController;
  late TextEditingController _searchTextEditingController;
  late FocusNode _petTypeNameFocusNode;

  static const Map<int, TableColumnWidth> _petChronicDiseaseTableColumnWidth =
      <int, TableColumnWidth>{
    0: FlexColumnWidth(0.1),
    1: FlexColumnWidth(0.2),
    2: FlexColumnWidth(0.2),
  };
  static const Map<int, TableColumnWidth>
      _defaultNutrientLimitTableColumnWidth = <int, TableColumnWidth>{
    0: FlexColumnWidth(0.1),
    1: FlexColumnWidth(0.2),
    2: FlexColumnWidth(0.1),
    3: FlexColumnWidth(0.15),
    4: FlexColumnWidth(0.15),
  };
  static const double _tableHeaderPadding = 12;
  static const TextStyle _tableHeaderTextStyle =
      TextStyle(fontSize: 17, color: Colors.white);
  static const double _tableHeight = 600;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _viewModel = UpdatePetTypeInfoViewModel();
    _petTypeNameController = TextEditingController();
    _searchTextEditingController = TextEditingController();
    _petTypeNameFocusNode = FocusNode();
    _viewModel.petChronicDiseaseList = widget.petTypeInfo.petChronicDisease;
    _viewModel.filteredPetChronicDiseaseList = _viewModel.petChronicDiseaseList;
    _viewModel.defaultNutrientLimitList = List.from(
      widget.petTypeInfo.defaultNutrientLimitList.map(
        (e) => NutrientLimitInfoModel(
            nutrientName: e.nutrientName, unit: e.unit, min: e.min, max: e.max),
      ),
    );
    _petTypeNameController.text = widget.petTypeInfo.petTypeName;
    _petTypeNameFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _petTypeNameController.dispose();
    _searchTextEditingController.dispose();
    _petTypeNameFocusNode.removeListener;
    _petTypeNameFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Completer<bool> completer = Completer<bool>();
        widget.isCreate
            ? AdminCancelPopup(
                    cancelText: 'ยกเลิกการเพิ่มข้อมูลชนิดสัตว์เลี้ยง',
                    context: context)
                .show()
            : AdminCancelPopup(
                    cancelText: 'ยกเลิกการเเก้ไขข้อมูลชนิดสัตว์เลี้ยง',
                    context: context)
                .show();
        return completer.future;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: _body(),
      ),
    );
  }

  FutureBuilder<List<PetChronicDiseaseModel>> _body() {
    return FutureBuilder<List<PetChronicDiseaseModel>>(
      future: _viewModel.petChronicDiseaseListData,
      builder: (context, AsyncSnapshot<List<PetChronicDiseaseModel>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const AdminLoadingScreenWithText();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                constraints:
                    const BoxConstraints(maxWidth: adminScreenMaxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _routingGuide(),
                    const SizedBox(height: 5),
                    _header(),
                    const SizedBox(height: 10),
                    _defaultNutrientLimitTable(),
                    const SizedBox(height: 20),
                    _petChronicDiseaseTable(),
                    const SizedBox(height: 15),
                    _acceptButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
        return const Text('No data available');
      },
    );
  }

  Widget _defaultNutrientLimitTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "การจำกัดโภชนาการเริ่มต้น",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        const SizedBox(height: 6),
        _defaultNutrientLimitTableHeader(),
        _defaultNutrientLimitTableBody(),
      ],
    );
  }

  void _minAmountChange({required int index, required double amount}) {
    setState(() {
      _viewModel.onMinAmountChange(index: index, amount: amount);
    });
  }

  void _maxAmountChange({required int index, required double amount}) {
    setState(() {
      _viewModel.onMaxAmountChange(index: index, amount: amount);
    });
  }

  Widget _defaultNutrientLimitTableBody() {
    return SizedBox(
      height: _tableHeight,
      child: ListView.builder(
        itemCount: _viewModel.defaultNutrientLimitList.length,
        itemBuilder: (context, index) {
          return NutrientLimitTableCell(
            index: index,
            tableColumnWidth: _defaultNutrientLimitTableColumnWidth,
            minAmountChangeCallback: _minAmountChange,
            maxAmountChangeCallback: _maxAmountChange,
            nutrientLimitInfo: _viewModel.defaultNutrientLimitList[index],
          );
        },
      ),
    );
  }

  Widget _defaultNutrientLimitTableHeader() {
    return Table(
      columnWidths: _defaultNutrientLimitTableColumnWidth,
      children: const [
        TableRow(
          decoration: BoxDecoration(
            color: specialBlack,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'ลำดับที่',
                    style: _tableHeaderTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'สารอาหาร',
                    style: _tableHeaderTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'หน่วย',
                    style: _tableHeaderTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'min (%DM)',
                    style: _tableHeaderTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'max (%DM)',
                    style: _tableHeaderTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Text _routingGuide() {
    return Text(
      widget.isCreate
          ? "จัดการข้อมูลชนิดสัตว์เลี้ยง / เพิ่มข้อมูลชนิดสัตว์เลี้ยง"
          : "จัดการข้อมูลชนิดสัตว์เลี้ยง / ข้อมูลชนิดสัตว์เลี้ยง / แก้ไขข้อมูลชนิดสัตว์เลี้ยง",
      style: const TextStyle(color: Colors.grey, fontSize: 20),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "เพิ่มข้อมูลชนิดสัตว์เลี้ยง",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: headerTextFontSize,
          ),
        ),
        const SizedBox(height: 5),
        _petTypeNamePart(),
      ],
    );
  }

  void _onSearchTextChanged({required String searchText}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _viewModel.onUserSearchIngredient(searchText: searchText);
      setState(() {});
    });
  }

  Widget _searchBar() {
    return SizedBox(
      width: 600,
      child: FilterSearchBar(
        onSearch: _onSearchTextChanged,
        searchTextEditingController: _searchTextEditingController,
        labelText: "ค้นหาโรคประจำตัวสัตว์เลี้ยง",
      ),
    );
  }

  void _onPetTypeNameChanged(String word) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  Widget _petTypeNamePart() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      width: 500,
      child: TextField(
        onTap: () {
          _petTypeNameController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _petTypeNameController.text.length,
          );
        },
        onChanged: _onPetTypeNameChanged,
        focusNode: _petTypeNameFocusNode,
        controller: _petTypeNameController,
        style: const TextStyle(fontSize: headerInputTextFontSize),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            minWidth: 15,
          ),
          prefixIcon: _petTypeNamePrefixWord(),
          fillColor: Colors.white,
          filled: true,
          labelText: "ชนิดสัตว์เลี้ยง",
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: const EdgeInsets.only(left: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
                color: _petTypeNameController.text.isEmpty
                    ? Colors.red
                    : Colors.black,
                width: _petTypeNameController.text.isEmpty ? 1.4 : 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }

  Container _petTypeNamePrefixWord() {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: _petTypeNameFocusNode.hasFocus ||
              _petTypeNameController.text.isNotEmpty
          ? const SizedBox()
          : const MouseRegion(
              cursor: SystemMouseCursors.text,
              child: Row(
                children: [
                  Text(
                    " ชื่อชนิดสัตว์เลี้ยง",
                    style: TextStyle(color: Colors.grey, fontSize: 19),
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red, fontSize: 19),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _petChronicDiseaseTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "โรคประจำตัวสัตว์เลี้ยง",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _searchBar(),
            const Spacer(),
            _addPetChronicDiseaseButton(),
          ],
        ),
        const SizedBox(height: 10),
        _tableHeader(),
        _petChronicDiseaseTableBody(),
      ],
    );
  }

  Table _tableHeader() {
    return Table(
      columnWidths: _petChronicDiseaseTableColumnWidth,
      children: const [
        TableRow(
          decoration: BoxDecoration(
            color: Color.fromRGBO(16, 16, 29, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'ลำดับที่',
                    style: _tableHeaderTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'รหัสโรคประจำตัวสัตว์เลี้ยง',
                    style: _tableHeaderTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'ชื่อโรคประจำตัวสัตว์เลี้ยง',
                    style: _tableHeaderTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onUserDeletePetChronicDisease(
      {required PetChronicDiseaseModel petChronicDiseaseData}) async {
    _viewModel.onUserDeletePetChronicDisease(
        petChronicDiseaseData: petChronicDiseaseData);
    setState(() {});
  }

  Widget _petChronicDiseaseTableBody() {
    return SizedBox(
      height: _tableHeight,
      child: _viewModel.filteredPetChronicDiseaseList.isEmpty
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(gradient: tableBackGroundGradient),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ไม่มีข้อมูลโรคประจำตัวสัตว์เลี้ยง",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 50)
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(gradient: tableBackGroundGradient),
              height: 75.0 * _viewModel.petChronicDiseaseList.length,
              child: ListView.builder(
                itemCount: _viewModel.petChronicDiseaseList.length,
                itemBuilder: (context, index) {
                  return PetChronicDiseaseTableCell(
                    index: index,
                    tableColumnWidth: _petChronicDiseaseTableColumnWidth,
                    petChronicDisease: _viewModel.petChronicDiseaseList[index],
                    petTypeName: _petTypeNameController.text,
                    onUserDeletePetChronicDiseaseCallBack: (
                        {required PetChronicDiseaseModel
                            petChronicDiseaseData}) {
                      _onUserDeletePetChronicDisease(
                          petChronicDiseaseData: petChronicDiseaseData);
                    },
                    onUserAddPetChronicDiseaseCallBack: (
                        {required List<NutrientLimitInfoModel>
                            nutrientLimitInfo,
                        required String petChronicDiseaseID,
                        required String petChronicDiseaseName}) {
                      _onUserAddPetChronicDisease(
                          nutrientLimitInfo: nutrientLimitInfo,
                          petChronicDiseaseID: petChronicDiseaseID,
                          petChronicDiseaseName: petChronicDiseaseName);
                    },
                    onUserEditPetChronicDiseaseCallBack: (
                        {required String petChronicDiseaseId}) {
                      _onUserEditPetChronicDisease(
                          petChronicDiseaseId: petChronicDiseaseId);
                    },
                  );
                },
              ),
            ),
    );
  }

  void _onUserAddPetChronicDisease(
      {required List<NutrientLimitInfoModel> nutrientLimitInfo,
      required String petChronicDiseaseID,
      required String petChronicDiseaseName}) async {
    setState(() {});
    _viewModel.onUserAddPetChronicDisease(
        nutrientLimitInfo: nutrientLimitInfo,
        petChronicDiseaseID: petChronicDiseaseID,
        petChronicDiseaseName: petChronicDiseaseName);
  }

  void _onUserEditPetChronicDisease({required String petChronicDiseaseId}) {
    _viewModel.onUserEditPetChronicDisease(
        petChronicDiseaseId: petChronicDiseaseId);
    setState(() {});
  }

  Widget _addPetChronicDiseaseButton() {
    return SizedBox(
      height: 43,
      child: AdminAddObjectButton(
          addObjectCallback: () async {
            Navigator.push(
              context,
              NavigationUpward(
                  targetPage: UpdatePetChronicDiseaseView(
                    onUserAddPetChronicDiseaseCallBack:
                        _onUserAddPetChronicDisease,
                    petTypeName: _petTypeNameController.text,
                    isCreate: true,
                    petChronicDiseaseInfo: PetChronicDiseaseModel(
                        petChronicDiseaseId: Random().nextInt(999).toString(),
                        petChronicDiseaseName: "",
                        nutrientLimitInfo:
                            _viewModel.petChronicDiseaseNutrientLimitList),
                    onUserEditPetChronicDiseaseCallBack: (
                        {required String petChronicDiseaseId}) {
                      _onUserEditPetChronicDisease(
                          petChronicDiseaseId: petChronicDiseaseId);
                    },
                    onUserDeletePetChronicDiseaseCallBack: (
                        {required PetChronicDiseaseModel
                            petChronicDiseaseData}) {
                      _onUserDeletePetChronicDisease(
                          petChronicDiseaseData: petChronicDiseaseData);
                    },
                  ),
                  durationInMilliSec: 700),
            );
          },
          addObjectText: " เพิ่มข้อมูลโรคประจำตัวสัตว์เลี้ยง"),
    );
  }

  Future<void> _handleAddPetTypeInfo() async {
    Navigator.pop(context);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(child: AdminLoadingScreen());
        });
    try {
      await _viewModel.onUserAddPetTypeInfo(
          petTypeName: _petTypeNameController.text,
          petTypeID: Random().nextInt(999).toString());
      if (!context.mounted) return;
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 1600), () {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(context,
            NavigationDownward(targetPage: const PetTypeInfoManagementView()));
      });
      AdminSuccessPopup(
              context: context,
              successText: 'เพิ่มข้อมูลชนิดสัตว์เลี้ยงสำเร็จ!!')
          .show();
    } catch (e) {
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 2200), () {
        Navigator.pop(context);
      });
      AdminErrorPopup(context: context, errorMessage: e.toString()).show();
    }
  }

  Future<void> _handleEditPetTypeInfo() async {
    Navigator.pop(context);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(child: AdminLoadingScreen());
        });
    try {
      PetTypeInfoModel petTypeInfoData = PetTypeInfoModel(
          petTypeId: widget.petTypeInfo.petTypeId,
          petTypeName: _petTypeNameController.text,
          defaultNutrientLimitList: _viewModel.defaultNutrientLimitList,
          petChronicDisease: _viewModel.petChronicDiseaseList);
      await _viewModel.onUserEditPetTypeInfo(
          petTypeID: widget.petTypeInfo.petTypeId,
          petTypeName: _petTypeNameController.text);
      if (!context.mounted) return;
      Navigator.pop(context);
      Future.delayed(
        const Duration(milliseconds: 1600),
        () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            NavigationDownward(
              targetPage: PetTypeInfoView(
                petTypeInfo: petTypeInfoData,
                onUserDeletePetTypeInfoCallBack: (
                    {required String petTypeId}) async {
                  await widget.onUserDeletePetTypeInfoCallBack(
                      petTypeId: petTypeId);
                },
                isJustUpdate: true,
              ),
            ),
          );
        },
      );
      AdminSuccessPopup(
              context: context,
              successText: 'เเก้ไขข้อมูลชนิดสัตว์เลี้ยงสำเร็จ!!')
          .show();
    } catch (e) {
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 2200), () {
        Navigator.pop(context);
      });
      AdminErrorPopup(context: context, errorMessage: e.toString()).show();
    }
  }

  void _updatePetTypeInfoFunction() {
    if (_petTypeNameController.text.isEmpty) {
      AdminWarningPopup(
              context: context, warningText: 'กรุณากรอกชื่อชนิดสัตว์เลี้ยง!')
          .show();
    } else {
      widget.isCreate
          ? AdminConfirmPopup(
              context: context,
              confirmText: 'ยืนยันการเพิ่มข้อมูลชนิดสัตว์เลี้ยง?',
              callback: _handleAddPetTypeInfo,
            ).show()
          : AdminConfirmPopup(
              context: context,
              confirmText: 'ยืนยันการเเก้ไขข้อมูลชนิดสัตว์เลี้ยง?',
              callback: _handleEditPetTypeInfo,
            ).show();
    }
  }

  Row _acceptButton() {
    bool isButtonDisable = _petTypeNameController.text.isEmpty;

    return Row(
      children: [
        const Spacer(),
        SizedBox(
          height: 45,
          width: 100,
          child: ElevatedButton(
            onPressed: () async {
              _updatePetTypeInfoFunction();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonDisable
                  ? disableButtonBackground
                  : acceptButtonBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'ตกลง',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
