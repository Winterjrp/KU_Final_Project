import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/hive_models/pet_profile_model.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/normal/home/home_view_model.dart';
import 'package:untitled1/modules/normal/home/models/home_model.dart';
import 'package:untitled1/modules/normal/home/widgets/user_pet_info_card.dart';
import 'package:untitled1/modules/normal/update_pet_profile/update_pet_profile_view.dart';
import 'package:untitled1/widgets/background.dart';
import 'package:untitled1/widgets/user_profile_app_bar.dart';
import 'package:untitled1/widgets/bottom_navigation_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.userInfo, Key? key}) : super(key: key);

  final UserInfoModel userInfo;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late double height;
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _viewModel.getHomeData(userID: widget.userInfo.userID);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(199, 232, 229, 1),
      bottomNavigationBar:
          ProjectNavigationBar(index: 0, userInfo: widget.userInfo),
      body: SafeArea(
        child: Stack(
          children: [
            const BackGround(
                topColor: Color.fromRGBO(177, 225, 219, 0.4),
                bottomColor: Color.fromRGBO(199, 232, 229, 1)),
            _content(height, width),
          ],
        ),
      ),
    );
  }

  FutureBuilder<HomeModel> _content(double height, double width) {
    return FutureBuilder<HomeModel>(
        future: _viewModel.homeDataFetch,
        builder: (context, AsyncSnapshot<HomeModel> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return _loadingScreen();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Column(
              children: [
                UserProfileAppBar(
                  userInfo: widget.userInfo,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      _header(),
                      // const SizedBox(height: 10),
                      _viewModel.homeData.petList.isEmpty
                          ? _noPetWarn(width)
                          : _userPetInfo(height: height, context: context),
                      const SizedBox(height: 5),
                      _addPetButton()
                    ],
                  ),
                ),
              ],
            );
          }
          return const Text('No data available');
        });
  }

  Column _noPetWarn(double width) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(228, 234, 240, 1),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            width: width * 0.8,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const Text(
                  "ยังไม่ได้เพิ่มข้อมูลสัตว์เลี้ยง?",
                  style: TextStyle(
                      fontSize: 17, color: Color.fromRGBO(28, 28, 44, 1)),
                ),
                const SizedBox(height: 20),
                Transform.translate(
                  offset: const Offset(100, 0),
                  child: Transform.scale(
                    scale: 1.7,
                    child: SizedBox(
                      height: 290,
                      child: SvgPicture.asset(
                        'assets/pet_owner.svg',
                        // semanticsLabel:
                        //     'My SVG Image',
                        // width: 200,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "เพิ่มสัตว์เลี้ยงได้เลย!!",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(28, 28, 44, 1)),
                ),
              ],
            )),
        const SizedBox(height: 15),
      ],
    );
  }

  Container _header() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "สัตว์เลี้ยงของฉัน",
        style: TextStyle(
            fontSize: 25, color: primary, fontWeight: FontWeight.bold),
      ),
    );
  }

  SingleChildScrollView _userPetInfo(
      {required double height, required BuildContext context}) {
    return SingleChildScrollView(
        child: SizedBox(
      height: height * 0.62,
      child: ListView.builder(
        itemCount: _viewModel.homeData.petList.length,
        itemBuilder: (context, index) {
          return UserPetInfoCard(
            context: context,
            userInfo: widget.userInfo,
            petProfileInfo: _viewModel.homeData.petList[index],
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

  Widget _addPetButton() {
    return Container(
        width: 200,
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdatePetProfileView(
                        userInfo: widget.userInfo,
                        isCreate: true,
                        petProfileInfo: PetProfileModel(
                            petID: "-1",
                            petName: "-1",
                            petType: "-1",
                            factorType: "-1",
                            petFactorNumber: -1,
                            petWeight: -1,
                            petNeuteringStatus: "-1",
                            petAgeType: "-1",
                            petPhysiologyStatus: "-1",
                            petChronicDisease: [],
                            petActivityType: "-1",
                            updateRecent: ""),
                      )),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            backgroundColor: const Color.fromRGBO(254, 208, 163, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_rounded,
                size: 40,
                color: primary,
              ),
              Text(
                " เพิ่มสัตว์เลี้ยง",
                style: TextStyle(
                    fontSize: 17, color: primary, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}
