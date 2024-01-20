import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/constants/enum/select_ingredient_type_enum.dart';
import 'package:untitled1/modules/normal/select_ingredient/select_ingredient_view_model.dart';
import 'package:untitled1/modules/normal/widgets/background.dart';
import 'package:untitled1/widgets/dropdown/multiple_dropdown_search.dart';

class SelectIngredientView extends StatefulWidget {
  const SelectIngredientView({Key? key}) : super(key: key);

  @override
  State<SelectIngredientView> createState() => _SelectIngredientViewState();
}

class _SelectIngredientViewState extends State<SelectIngredientView> {
  late List<String> _ingredientList;
  late SelectIngredientViewModel _viewModel;
  late String _selectIngredientType;
  // late List<String> _selectedIngredientList;
  // late List<String> _nonSelectedIngredientList;
  // late Set<String> _selectedIngredientSet;
  // late Set<String> _nonSelectedIngredientListSet;
  final double _labelTextSize = 21;
  final double _headerTextSize = 20;
  final double _choiceTextSize = 17.5;
  final Color _primaryColor = primary;
  final GlobalKey<DropdownSearchState<String>> _selectIngredientKey =
      GlobalKey<DropdownSearchState<String>>();

  @override
  void initState() {
    super.initState();
    _viewModel = SelectIngredientViewModel();
    _selectIngredientType = "";
    _ingredientList = [
      "เนื้อไก่",
      "เนื้อหมู",
      "ผักชี",
      "น้ำมัน",
      "ข้าว",
      "มันฝรั่ง",
      "หน่อไม้",
      "มะเขือเทศ",
      "เนื้อปลา"
    ];
    // _selectedIngredientList = _ingredientList;
    // _nonSelectedIngredientList = _ingredientList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.keyboard_backspace_rounded, color: primary),
            onPressed: () {
              // widget.isJustUpdate
              //     ? Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           HomeView(userInfo: widget.userInfo)),
              // )
              //     :
              Navigator.of(context).pop();
            },
          ),
          title: const Center(
              child: Text("เลือกวัตถุดิบ      ",
                  style:
                      TextStyle(color: primary, fontWeight: FontWeight.bold))),
          backgroundColor: const Color.fromRGBO(194, 190, 241, 0.4)),
      body: Stack(
        children: [
          const BackGround(
            topColor: Color.fromRGBO(194, 190, 241, 0.4),
            bottomColor: Color.fromRGBO(72, 70, 109, 0.1),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _selectedIngredientPart(),
                  const SizedBox(height: 30),
                  // _selectIngredientTypePart(),
                  const SizedBox(height: 480),
                  _searchFoodRecipesButton(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center _searchFoodRecipesButton() {
    return Center(
      child: SizedBox(
        width: 450,
        height: 55,
        child: ElevatedButton(
          onPressed: () async {
            _selectIngredientType == "" ? null : print("dpfgk");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('ค้นหาสูตรอาหาร', style: TextStyle(fontSize: 17)),
        ),
      ),
    );
  }

  Column _selectIngredientTypePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerText(text: "เลือกประเภทสูตรอาหารที่ต้องการ"),
        RadioListTile(
          title: Text(SelectIngredientTypeEnum.selectIngredientTypeChoice1,
              style: TextStyle(fontSize: _choiceTextSize)),
          groupValue: _selectIngredientType,
          onChanged: (value) {
            setState(() {
              _selectIngredientType = value!;
            });
          },
          activeColor: _primaryColor,
          value: SelectIngredientTypeEnum().getSelectIngredientType(
              description:
                  SelectIngredientTypeEnum.selectIngredientTypeChoice2),
        ),
        RadioListTile(
          title: Text(SelectIngredientTypeEnum.selectIngredientTypeChoice2,
              style: TextStyle(fontSize: _choiceTextSize)),
          groupValue: _selectIngredientType,
          onChanged: (value) {
            setState(() {
              _selectIngredientType = value!;
            });
          },
          activeColor: _primaryColor,
          value: SelectIngredientTypeEnum().getSelectIngredientType(
              description:
                  SelectIngredientTypeEnum.selectIngredientTypeChoice1),
        ),
      ],
    );
  }

  Text _headerText({required String text}) {
    return Text(text,
        style: TextStyle(
          fontSize: _labelTextSize,
          fontWeight: FontWeight.bold,
        ));
  }

  Column _selectedIngredientPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerText(text: "เลือกวัตถุดิบที่ต้องการในสูตรอาหาร"),
        const SizedBox(height: 15),
        CustomMultipleDropdownSearch(
          primaryColor: _primaryColor,
          isCreate: true,
          value: _viewModel.selectedIngredient,
          choiceItemList: _ingredientList,
          updateValueCallback: ({required List<String> value}) {
            _viewModel.selectedIngredient = value;
            setState(() {});
          },
          dropdownKey: _selectIngredientKey,
          labelTextSize: _labelTextSize,
          searchText: 'ค้นหาวัตถุดิบ',
          hintText: 'เลือกวัตถุดิบ',
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text("ในสูตรอาหารจะมีแค่วัตถุดิบที่ท่านเลือกเท่านั้น",
                style: TextStyle(fontSize: 17)),
            Text(
              "*",
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ],
    );
  }
}
