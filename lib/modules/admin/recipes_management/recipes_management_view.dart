import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/constants/main_page_index_constants.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/modules/admin/add_recipes/add_recipe_view.dart';
import 'package:untitled1/modules/admin/admin_home/admin_home_view.dart';
import 'package:untitled1/modules/admin/user_management/widgets/filter_search_bar.dart';
import 'package:untitled1/modules/admin/widgets/admin_appbar.dart';
import 'package:untitled1/modules/admin/widgets/admin_drawer.dart';
import 'package:untitled1/modules/admin/recipes_management/recipes_management_view_model.dart';
import 'package:untitled1/modules/admin/recipes_management/widgets/recipes_management_card.dart';
import 'package:untitled1/modules/admin/widgets/admin_loading_screen_with_text.dart';
import 'package:untitled1/utility/navigation_with_animation.dart';

class RecipesManagementView extends StatefulWidget {
  const RecipesManagementView({Key? key}) : super(key: key);

  @override
  State<RecipesManagementView> createState() => _RecipesManagementViewState();
}

class _RecipesManagementViewState extends State<RecipesManagementView> {
  late double height;
  late RecipesManagementViewModel _viewModel;
  late TextEditingController _searchTextEditingController;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _viewModel = RecipesManagementViewModel();
    _viewModel.fetchRecipesListData();
    _searchTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
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
            currentIndex: MainPageIndexConstants.recipeManagementIndex),
        appBar: const AdminAppBar(),
        body: FutureBuilder<List<RecipesModel>>(
            future: _viewModel.recipesListData,
            builder: (context, AsyncSnapshot<List<RecipesModel>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const AdminLoadingScreenWithText();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(),
                      const SizedBox(height: 15),
                      Expanded(
                        child: Column(
                          children: [
                            _recipesInfo(height: height, context: context),
                            const SizedBox(height: 15),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const Text('No data available');
            }),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          child: Text(
            "จัดการข้อมูลสูตรอาหารสัตว์เลี้ยง",
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
            _addRecipesButton(),
          ],
        ),
      ],
    );
  }

  void _onSearchTextChanged({required String searchText}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // _viewModel.onUserSearchIngredient(searchText: searchText);
      setState(() {});
    });
  }

  Widget _searchBar() {
    return FilterSearchBar(
      onSearch: _onSearchTextChanged,
      searchTextEditingController: _searchTextEditingController,
      labelText: "ค้นหาสูตรอาหาร",
    );
  }

  Widget _recipesInfo({required double height, required BuildContext context}) {
    return Container(
      constraints: BoxConstraints(maxHeight: height * 0.72),
      height: 75.0 * _viewModel.recipesList.length,
      child: ListView.builder(
        itemCount: _viewModel.recipesList.length,
        itemBuilder: (context, index) {
          return RecipesManagementCard(
            index: index,
            context: context,
            viewModel: _viewModel,
            // deletePetInfoCallBack: onUserDeleteCallBack
          );
        },
      ),
    );
  }

  Widget _addRecipesButton() {
    return SizedBox(
      height: 43,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.push(
            context,
            NavigationUpward(
              targetPage: const AddRecipesView(),
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
              " เพิ่มข้อมูลสูตรอาหารสัตว์เลี้ยง",
              style: TextStyle(fontSize: 18, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
