import 'package:flutter/material.dart';
import 'package:untitled1/constants/main_page_index_constants.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/modules/admin/widgets/admin_drawer.dart';
import 'package:untitled1/modules/admin/pet_type_info_management/pet_type_info_management_view_model.dart';
import 'package:untitled1/modules/admin/pet_type_info_management/widgets/pet_type_info_management_card.dart';
import 'package:untitled1/modules/admin/update_pet_type_info/add_pet_type_info_view.dart';

class PetTypeInfoManagementView extends StatefulWidget {
  const PetTypeInfoManagementView({Key? key}) : super(key: key);

  @override
  State<PetTypeInfoManagementView> createState() =>
      _PetTypeInfoManagementViewState();
}

class _PetTypeInfoManagementViewState extends State<PetTypeInfoManagementView> {
  late double height;
  late PetTypeInfoManagementViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PetTypeInfoManagementViewModel();
    _viewModel.getPetTypeInfoData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      drawer: const AdminDrawer(
          currentIndex: MainPageIndexConstants.petTypeManagementIndex),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (context) => // Ensure Scaffold is in context
              IconButton(
            icon: const Icon(
              Icons.menu,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        // title: const Center(child: Text("ฟังก์ชันสำหรับผู้ดูแลระบบ")),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: FutureBuilder<List<PetTypeInfoModel>>(
            future: _viewModel.petTypeInfoData,
            builder: (context, AsyncSnapshot<List<PetTypeInfoModel>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return _loadingScreen();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          _header(),
                          const SizedBox(height: 15),
                          _userPetInfo(height: height, context: context),
                          const SizedBox(height: 15),
                          _addPetTypeInfoButton()
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Text('No data available');
            }),
      ),
    );
  }

  Widget _header() {
    return const SizedBox(
      child: Text(
        "จัดการข้อมูลชนิดสัตว์เลี้ยง",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 42,
          // color: kPrimaryDarkColor,
        ),
      ),
    );
  }

  SingleChildScrollView _userPetInfo(
      {required double height, required BuildContext context}) {
    Future<void> deletePetTypeDataCallback(
        {required String petTypeInfoID}) async {
      _viewModel.deletePetTypeData(petTypeInfoID: petTypeInfoID);
    }

    return SingleChildScrollView(
        child: Container(
      constraints: BoxConstraints(maxHeight: height * 0.72),
      height: 75.0 * _viewModel.petTypeInfo.length,
      child: ListView.builder(
        itemCount: _viewModel.petTypeInfo.length,
        itemBuilder: (context, index) {
          return PetTypeInfoManagementCard(
            index: index,
            context: context,
            viewModel: _viewModel,
            deletePetTypeInfoCallBack: deletePetTypeDataCallback,
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

  Widget _addPetTypeInfoButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddPetTypeInfoView()),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 50),
                  Text(
                    " เพิ่มข้อมูลชนิดสัตว์เลี้ยง",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
