import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/select_admin_funtion/select_admin_function_view.dart';
import 'package:untitled1/modules/normal/home/home_view.dart';
import 'package:untitled1/modules/normal/setting/setting_view.dart';

class ProjectNavigationBar extends StatelessWidget {
  const ProjectNavigationBar({
    required this.index,
    required this.userInfo,
    Key? key,
  }) : super(key: key);
  final int index;
  final UserInfoModel userInfo;
  // final HomeModel homeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(199, 232, 229, 1),
          ),
          Container(
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), // Adjust the radius as needed
                topRight: Radius.circular(30), // Adjust the radius as needed
              ),
            ),
            child: (userInfo.userRole.isPetFoodManagementAdmin ||
                    userInfo.userRole.isUserManagementAdmin)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                          icon: Icons.pets,
                          // label: 'Home',
                          navigationIndex: 0,
                          context: context),
                      _buildNavItem(
                          icon: Icons.settings_outlined,
                          // label: 'Settings',
                          navigationIndex: 1,
                          context: context),
                      _buildNavItem(
                          icon: Icons.admin_panel_settings,
                          // label: 'Admin',
                          navigationIndex: 2,
                          context: context),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                          icon: Icons.pets,
                          // label: 'Home',
                          navigationIndex: 0,
                          context: context),
                      _buildNavItem(
                          icon: Icons.person,
                          // label: 'Settings',
                          navigationIndex: 1,
                          context: context),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon,
      // required String label,
      required int navigationIndex,
      required BuildContext context}) {
    bool isHighLight() {
      if (index == navigationIndex) {
        return true;
      }
      return false;
    }

    Color color = Colors.white;
    return Center(
      child: GestureDetector(
        onTap: () async {
          if (navigationIndex == 0) {
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(userInfo: userInfo),
              ),
            );
          } else if (navigationIndex == 1) {
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SettingView(userInfo: userInfo),
              ),
            );
          } else if (navigationIndex == 2) {
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SelectAdminFunctionView(userInfo: userInfo),
              ),
            );
          }
        },
        child: isHighLight()
            ? Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isHighLight()
                        ? const Color.fromRGBO(203, 139, 151, 1)
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 35,
                  ),
                ),
              )
            : Icon(
                icon,
                color: color,
                size: 35,
              ),
      ),
    );
  }
}
