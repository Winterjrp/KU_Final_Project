import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';

class SelectIngredientView extends StatefulWidget {
  const SelectIngredientView({Key? key}) : super(key: key);

  @override
  State<SelectIngredientView> createState() => _SelectIngredientViewState();
}

class _SelectIngredientViewState extends State<SelectIngredientView> {
  late List<String> _ingredientList;
  late List<String> _selectedIngredient;
  late List<String> _nonSelectedIngredient;
  late List<String> _selectedIngredientList;
  late List<String> _nonSelectedIngredientList;
  late Set<String> _selectedIngredientSet;
  late Set<String> _nonSelectedIngredientSet;
  late Set<String> _selectedIngredientListSet;
  late Set<String> _nonSelectedIngredientListSet;
  final double _labelTextSize = 18;
  final double _headerTextSize = 20;
  @override
  void initState() {
    super.initState();
    // _viewModel = AddPetInfoViewModel();
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
    _selectedIngredient = [];
    _nonSelectedIngredient = [];
    _selectedIngredientList = _ingredientList;
    _nonSelectedIngredientList = _ingredientList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: Text("เลือกวัตถุดิบ       ")),
          backgroundColor: primary),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _selectedIngredientPart(),
              const SizedBox(height: 40),
              _nonSelectedIngredientPart(),
              const SizedBox(height: 90),
              Center(
                child: SizedBox(
                  width: 450,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => SelectIngredientView(),
                      //     ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(58, 180, 106, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('ค้นหาสูตรอาหาร',
                        style: TextStyle(fontSize: 17)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _nonSelectedIngredientPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("เลือกวัตถุดิบที่ไม่ต้องการ",
            style: TextStyle(
                fontSize: _headerTextSize, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        DropdownSearch<String>.multiSelection(
          popupProps: PopupPropsMultiSelection.menu(
            showSearchBox: true,
            showSelectedItems: true,
            searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
              suffixIcon: const Icon(Icons.search),
              labelText: "ค้นหาวัตถุดิบ",
              labelStyle: const TextStyle(fontSize: 16, height: 1),
              contentPadding: const EdgeInsets.only(left: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: tGrey),
              ),
            )),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "วัตถุดิบที่ไม่ต้องการ",
            hintStyle: TextStyle(fontSize: _labelTextSize, height: 1),
            contentPadding:
                const EdgeInsets.only(left: 15, top: 20, bottom: 20, right: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: tGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: tGrey),
            ),
          )),
          items: _nonSelectedIngredientList,
          onChanged: (value) {
            setState(() {
              _nonSelectedIngredient = value;
              _selectedIngredientListSet = Set.from(_selectedIngredientList);
              _nonSelectedIngredientSet = Set.from(_nonSelectedIngredient);
              _selectedIngredientList = (_selectedIngredientListSet
                      .difference(_nonSelectedIngredientSet))
                  .toList();
            });
            // _controller.animateTo(
            //   1000.0,
            //   duration: const Duration(seconds: 1),
            //   curve: Curves.ease,
            // );
          },
        ),
      ],
    );
  }

  Column _selectedIngredientPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("เลือกวัตถุดิบที่ต้องการ",
            style: TextStyle(
                fontSize: _headerTextSize, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        DropdownSearch<String>.multiSelection(
          popupProps: PopupPropsMultiSelection.menu(
            showSearchBox: true,
            showSelectedItems: true,
            searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
              suffixIcon: const Icon(Icons.search),
              labelText: "ค้นหาวัตถุดิบ",
              labelStyle: const TextStyle(fontSize: 16, height: 1),
              contentPadding: const EdgeInsets.only(left: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: tGrey),
              ),
            )),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "วัตถุดิบที่ต้องการ",
            hintStyle: TextStyle(fontSize: _labelTextSize, height: 1),
            contentPadding:
                const EdgeInsets.only(left: 15, top: 20, bottom: 20, right: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: tGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: tGrey),
            ),
          )),
          items: _selectedIngredientList,
          onChanged: (value) {
            setState(() {
              _selectedIngredient = value;
              _nonSelectedIngredientListSet =
                  Set.from(_nonSelectedIngredientList);
              _selectedIngredientSet = Set.from(_selectedIngredient);
              _nonSelectedIngredientList = (_nonSelectedIngredientListSet
                      .difference(_selectedIngredientSet))
                  .toList();
            });
            // _controller.animateTo(
            //   1000.0,
            //   duration: const Duration(seconds: 1),
            //   curve: Curves.ease,
            // );
          },
        ),
      ],
    );
  }
}
