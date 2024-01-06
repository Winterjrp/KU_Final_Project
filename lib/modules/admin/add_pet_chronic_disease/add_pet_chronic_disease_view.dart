import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/modules/admin/add_pet_chronic_disease/add_pet_chronic_view_model.dart';
import 'package:untitled1/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/modules/admin/add_pet_chronic_disease/widgets/add_pet_chronic_disease_cancel_popup.dart';
import 'package:untitled1/modules/admin/add_pet_chronic_disease/widgets/add_pet_chronic_disease_confirm_popup.dart';
import 'package:untitled1/modules/admin/add_pet_chronic_disease/widgets/add_pet_chronic_disease_table_cell.dart';

typedef OnUserAddPetChronicDiseaseCallBack = void Function(
    {required List<NutrientLimitInfoModel> nutrientLimitInfo,
    required String petChronicDiseaseID,
    required String petChronicDiseaseName});

class AddPetChronicDiseaseView extends StatefulWidget {
  final OnUserAddPetChronicDiseaseCallBack addPetChronicDiseaseCallBack;
  final String petTypeName;
  const AddPetChronicDiseaseView(
      {required this.addPetChronicDiseaseCallBack,
      required this.petTypeName,
      Key? key})
      : super(key: key);

  @override
  State<AddPetChronicDiseaseView> createState() =>
      _AddPetChronicDiseaseViewState();
}

class _AddPetChronicDiseaseViewState extends State<AddPetChronicDiseaseView> {
  late AddPetChronicDiseaseViewModel _viewModel;
  late TextEditingController _petChronicDiseaseNameController;
  late String _petTypeName;
  final Map<int, TableColumnWidth> _tableColumnWidth =
      const <int, TableColumnWidth>{
    0: FlexColumnWidth(0.1),
    1: FlexColumnWidth(0.9),
    2: FlexColumnWidth(0.2),
    3: FlexColumnWidth(0.2),
  };
  final double _tableHeaderPadding = 20;

  @override
  void initState() {
    super.initState();
    _viewModel = AddPetChronicDiseaseViewModel();
    _petChronicDiseaseNameController = TextEditingController();
    _petTypeName = widget.petTypeName;
    if (widget.petTypeName == "") {
      _petTypeName = "...";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool confirm = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddPetChronicDiseaseCancelPopup();
            });
        return confirm;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              _petChronicDiseaseName(),
              const SizedBox(height: 15),
              _table(),
              const SizedBox(height: 20),
              _acceptButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Row _acceptButton(BuildContext context) {
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
                  return AddPetChronicDiseaseConfirmPopup(
                      viewModel: _viewModel,
                      petChronicDiseaseName:
                          _petChronicDiseaseNameController.text,
                      addPetChronicDiseaseCallBack:
                          widget.addPetChronicDiseaseCallBack);
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

  Widget _header() {
    return const SizedBox(
      child: Text(
        "เพิ่มโรคประจำตัวสัตว์เลี้ยง",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 42,
          // color: kPrimaryDarkColor,
        ),
      ),
    );
  }

  Widget _petChronicDiseaseName() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 50,
          width: 500,
          child: TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: _petChronicDiseaseNameController,
            style: const TextStyle(fontSize: 17),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: "ชื่อโรคประจำตัว",
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
            onChanged: (value) {},
          ),
        ),
        const SizedBox(width: 20),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            "ของ $_petTypeName",
            style: const TextStyle(fontSize: 19),
          ),
        )
      ],
    );
  }

  Widget _table() {
    return Expanded(
      child: Column(
        children: [
          _tableHeader(),
          _tableBody(),
        ],
      ),
    );
  }

  Widget _tableHeader() {
    return Table(
      columnWidths: _tableColumnWidth,
      border: TableBorder.symmetric(
        inside: const BorderSide(
          width: 1,
          // color: primary,
        ),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: primary,
            border: Border.all(
              width: 1,
              // color: primary,
            ),
            // color: kColorLightBlueBTN,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: const Center(
                  child: Text(
                    'ลำดับที่',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: const Center(
                  child: Text(
                    'สารอาหาร',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: const Center(
                  child: Text(
                    'min',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: const Center(
                  child: Text(
                    'max',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tableBody() {
    void minAmountChange({required int index, required double amount}) {
      setState(() {
        _viewModel.onMinAmountChange(index: index, amount: amount);
      });
    }

    void maxAmountChange({required int index, required double amount}) {
      setState(() {
        _viewModel.onMaxAmountChange(index: index, amount: amount);
      });
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.9,
              color: lightGrey,
            ),
            left: BorderSide(
              width: 0.9,
              color: lightGrey,
            ),
            right: BorderSide(
              width: 0.9,
              color: lightGrey,
            ),
          ),
        ),
        child: ListView.builder(
          itemCount: _viewModel.nutrientLimitList.length,
          itemBuilder: (context, index) {
            return AddPetChronicDiseaseTableCell(
              index: index,
              tableColumnWidth: _tableColumnWidth,
              minAmountChangeCallback: minAmountChange,
              maxAmountChangeCallback: maxAmountChange,
            );
          },
        ),
      ),
    );
  }
}
