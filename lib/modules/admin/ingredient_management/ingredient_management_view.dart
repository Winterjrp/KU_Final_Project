import 'package:flutter/material.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/add_ingredient/add_ingredient_view.dart';
import 'package:untitled1/modules/admin/ingredient_management/ingredient_management_view_model.dart';
import 'package:untitled1/modules/admin/ingredient_management/widgets/ingredient_info_card.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/modules/admin/user_management/widgets/filter_search_bar.dart';
import 'package:untitled1/widgets/user_profile_app_bar.dart';
import 'package:untitled1/widgets/bottom_navigation_bar.dart';

class IngredientManagementView extends StatefulWidget {
  const IngredientManagementView({required this.userInfo, Key? key})
      : super(key: key);

  final UserInfoModel userInfo;

  @override
  State<IngredientManagementView> createState() =>
      _IngredientManagementViewState();
}

class _IngredientManagementViewState extends State<IngredientManagementView> {
  late double height;
  late IngredientManagementViewModel _viewModel;

  late TextEditingController _searchTextEditingController;

  @override
  void initState() {
    super.initState();
    _viewModel = IngredientManagementViewModel();
    _viewModel.getIngredientData();
    _searchTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      bottomNavigationBar:
          ProjectNavigationBar(index: 2, userInfo: widget.userInfo),
      body: SafeArea(
        child: FutureBuilder<List<IngredientModel>>(
          future: _viewModel.ingredientListData,
          builder: (context, AsyncSnapshot<List<IngredientModel>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return _loadingScreen();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserProfileAppBar(
                    userInfo: widget.userInfo,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        _header(),
                        const SizedBox(height: 15),
                        _ingredientInfo(height: height, context: context),
                        const SizedBox(height: 15),
                        _addIngredientButton()
                      ],
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

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          child: Text(
            "จัดการวัตถุดิบ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 42,
              // color: kPrimaryDarkColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 60,
          width: 600,
          child: _searchBar(),
        ),
      ],
    );
  }

  Widget _searchBar() {
    void onSearchTextChanged({required String searchText}) {
      setState(() {
        // onUserSearchShopGroup(searchText);
      });
    }

    return SizedBox(
      // width: _screenWidth * 0.3,
      height: 35,
      child: FilterSearchBar(
        onSearch: onSearchTextChanged,
        textEditingController: _searchTextEditingController,
      ),
    );
  }

  SingleChildScrollView _ingredientInfo(
      {required double height, required BuildContext context}) {
    // Future<void> onUserDeleteCallBack({required String petID}) async {
    //   setState(() {});
    //   _viewModel.onUserDeletePetInfo(petID: petID);
    //   Navigator.of(context).pop();
    //   _viewModel.getHomeData(userID: widget.userID);
    // }

    return SingleChildScrollView(
        child: Container(
      constraints: BoxConstraints(maxHeight: height * 0.72),
      height: 75.0 * _viewModel.ingredientList.length,
      child: ListView.builder(
        itemCount: _viewModel.ingredientList.length,
        itemBuilder: (context, index) {
          return IngredientInfoCard(
            index: index,
            context: context,
            userInfo: widget.userInfo,
            ingredientList: _viewModel.ingredientList,
            // deletePetInfoCallBack: onUserDeleteCallBack
          );
        },
      ),
    ));
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

  Padding _addIngredientButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddIngredientView(userInfo: widget.userInfo)),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, size: 50),
                Text(
                  " เพิ่มข้อมูลวัตถุดิบ",
                  style: TextStyle(fontSize: 16),
                )
              ],
            )),
      ),
    );
  }
}
