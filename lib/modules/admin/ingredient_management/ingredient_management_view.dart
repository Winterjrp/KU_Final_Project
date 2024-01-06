import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/constants/main_page_index_constants.dart';
import 'package:untitled1/constants/nutrient_list.dart';
import 'package:untitled1/modules/admin/admin_home/admin_home_view.dart';
import 'package:untitled1/modules/admin/update_ingredient/update_ingredient_view.dart';
import 'package:untitled1/modules/admin/widgets/admin_appbar.dart';
import 'package:untitled1/modules/admin/widgets/admin_drawer.dart';
import 'package:untitled1/modules/admin/ingredient_management/ingredient_management_view_model.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/modules/admin/ingredient_management/widgets/ingredient_management_table_cell.dart';
import 'package:untitled1/modules/admin/user_management/widgets/filter_search_bar.dart';
import 'package:untitled1/modules/admin/widgets/admin_loading_screen_with_text.dart';
import 'package:untitled1/utility/navigation_with_animation.dart';

class IngredientManagementView extends StatefulWidget {
  const IngredientManagementView({Key? key}) : super(key: key);

  @override
  State<IngredientManagementView> createState() =>
      _IngredientManagementViewState();
}

class _IngredientManagementViewState extends State<IngredientManagementView> {
  late double height;
  late IngredientManagementViewModel _viewModel;
  late TextEditingController _searchTextEditingController;

  final TextStyle _headerTextStyle =
      const TextStyle(fontSize: 17, color: Colors.white);
  final Map<int, TableColumnWidth> _tableColumnWidth =
      const <int, TableColumnWidth>{
    0: FlexColumnWidth(0.07),
    1: FlexColumnWidth(0.2),
    2: FlexColumnWidth(1),
  };
  final double _tableHeaderPadding = 12;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _viewModel = IngredientManagementViewModel();
    _viewModel.getIngredientData();
    _searchTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return WillPopScope(
      onWillPop: () async {
        Completer<bool> completer = Completer<bool>();
        Navigator.pushReplacement(
          context,
          NavigationDownward(targetPage: const AdminHomeView()),
        );
        return completer.future;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const AdminDrawer(
            currentIndex: MainPageIndexConstants.ingredientManagementIndex),
        appBar: const AdminAppBar(),
        body: FutureBuilder<List<IngredientModel>>(
          future: _viewModel.ingredientListData,
          builder: (context, AsyncSnapshot<List<IngredientModel>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const AdminLoadingScreenWithText();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _header(),
                          const SizedBox(height: 15),
                          _ingredientListTable(height, context),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Text('No data available');
          },
        ),
      ),
    );
  }

  Widget _ingredientListTable(double height, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _tableHeader(),
          _tableBody(height: height, context: context),
        ],
      ),
    );
  }

  Table _tableHeader() {
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
          decoration: const BoxDecoration(
            color: Color.fromRGBO(16, 16, 29, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'ลำดับที่',
                    style: _headerTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'รหัสวัตุดิบ',
                    style: _headerTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'ชื่อวัตถุดิบ',
                    style: _headerTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          child: Text(
            "จัดการข้อมูลวัตถุดิบ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
              // color: kPrimaryDarkColor,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 600,
              child: _searchBar(),
            ),
            const Spacer(),
            _addIngredientButton(),
          ],
        ),
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
    return FilterSearchBar(
      onSearch: _onSearchTextChanged,
      searchTextEditingController: _searchTextEditingController,
      labelText: "ค้นหาวัตถุดิบ",
    );
  }

  Widget _tableBody({required double height, required BuildContext context}) {
    return Expanded(
      child: _viewModel.filterIngredientList.isEmpty
          ? Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ไม่มีข้อมูลวัตถุดิบ",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 50)
                ],
              ),
            )
          : ListView.builder(
              itemCount: _viewModel.filterIngredientList.length,
              itemBuilder: (context, index) {
                return IngredientTableCell(
                    index: index,
                    tableColumnWidth: _tableColumnWidth,
                    ingredientInfo: _viewModel.filterIngredientList[index]);
              },
            ),
    );
  }

  Widget _addIngredientButton() {
    return SizedBox(
      height: 43,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.push(
            context,
            NavigationUpward(
              targetPage: UpdateIngredientView(
                isCreate: true,
                ingredientInfo: IngredientModel(
                    ingredientID: Random().nextInt(999).toString(),
                    ingredientName: "",
                    nutrient: nutrientList),
              ),
              durationInMilliSec: 500,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: flesh,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, size: 36, color: Colors.black),
            Text(
              " เพิ่มข้อมูลวัตถุดิบ",
              style: TextStyle(fontSize: 18, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
