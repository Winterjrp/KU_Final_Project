import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/widgets/background.dart';

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
  late bool _isACheck;
  late bool _isBCheck;
  final double _labelTextSize = 18;
  final double _headerTextSize = 20;
  @override
  void initState() {
    super.initState();
    // _viewModel = AddPetInfoViewModel();
    _isACheck = false;
    _isBCheck = false;
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
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace_rounded, color: primary),
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
          title: Center(
              child: Text("เลือกวัตถุดิบ       ",
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
                  const SizedBox(height: 20),
                  _selectedIngredientPart(),
                  const SizedBox(height: 40),
                  _nonSelectedIngredientPart(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              activeColor: primary,
                              value: _isACheck,
                              onChanged: (bool? value) {
                                setState(() {});
                                _isACheck = value!;
                                _isBCheck = false;
                              }),
                          const Text(
                            "A",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Checkbox(
                              activeColor: primary,
                              value: _isBCheck,
                              onChanged: (bool? value) {
                                setState(() {});
                                _isBCheck = value!;
                                _isACheck = false;
                              }),
                          const Text(
                            "B",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 350),
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
                          backgroundColor: primary,
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
        ],
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
