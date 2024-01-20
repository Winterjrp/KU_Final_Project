import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/constants/main_page_index_constants.dart';
import 'package:untitled1/modules/admin/widgets/admin_appbar.dart';
import 'package:untitled1/modules/admin/widgets/admin_drawer.dart';
import 'package:untitled1/modules/admin/widgets/popup/admin_confirm_popup.dart';
import 'package:untitled1/modules/normal/login/responsive_login_view.dart';
import 'package:untitled1/provider/authentication_provider.dart';
import 'package:untitled1/utility/navigation_with_animation.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Completer<bool> completer = Completer<bool>();
        AdminConfirmPopup(
          context: context,
          confirmText: 'ยืนยันการออกจากระบบ?',
          callback: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              NavigationDownward(
                targetPage: ChangeNotifierProvider<AuthenticationProvider>(
                    create: (context) => AuthenticationProvider(),
                    child: const LoginView()),
              ),
            );
          },
        ).show();
        return completer.future;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        drawer: const AdminDrawer(
            currentIndex: MainPageIndexConstants.adminHomePageIndex),
        appBar: const AdminAppBar(),
        body: _body(),
      ),
    );
  }

  Padding _body() {
    return const Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 1300,
              child: Row(
                children: [
                  SizedBox(width: 350),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" สวัสดีคุณ",
                              style: TextStyle(
                                  fontSize: 40,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold)),
                          Text(" 'Temp'",
                              style: TextStyle(
                                  fontSize: 40,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Text(" ยินดีต้อนรับเข้าสู่หน้า..",
                          style: TextStyle(fontSize: 40, height: 1.4)),
                      Text(
                        "HOME!",
                        style: TextStyle(
                            fontSize: 270,
                            fontWeight: FontWeight.bold,
                            height: 1.02),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
