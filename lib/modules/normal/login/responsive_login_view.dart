import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/modules/admin/ingredient_management/ingredient_management_view.dart';
import 'package:untitled1/modules/admin/select_admin_funtion/select_admin_function_view.dart';
import 'package:untitled1/modules/normal/home/home_view.dart';
import 'package:untitled1/modules/normal/login/desktop_login_view.dart';
import 'package:untitled1/modules/normal/login/login_view_model.dart';
import 'package:untitled1/modules/normal/login/mobile_login_view.dart';
import 'package:untitled1/provider/authentication_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;
  late LoginViewModel _viewModel;
  bool _isMobile = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _viewModel = LoginViewModel();
  }

  Future<void> login() async {
    // bool isCredentialsValid = validateCredentials(username, password);
    bool isCredentialsValid = true;
    if (isCredentialsValid) {
      _viewModel.getUserInfo(
          username: _usernameController.text,
          password: _passwordController.text);
      if (_isMobile) {
        _viewModel.userInfoData.userRole.isUserManagementAdmin = false;
        _viewModel.userInfoData.userRole.isPetFoodManagementAdmin = false;
      }
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(userInfo: _viewModel.userInfoData),
        ),
        // context,
        // MaterialPageRoute(
        //     builder: (context) =>
        //         SelectAdminFunctionView(userInfo: _viewModel.userInfoData)),
      );
    } else {
      if (_usernameController.text == '') {
        context
            .read<AuthenticationProvider>()
            .updateErrorStatus(errorMessage: 'Please enter your username');
      } else if (_passwordController.text == '') {
        context
            .read<AuthenticationProvider>()
            .updateErrorStatus(errorMessage: 'Please enter your password');
      } else {
        context
            .read<AuthenticationProvider>()
            .updateErrorStatus(errorMessage: 'Invalid username or password');
      }
      _usernameController.text = '';
      _passwordController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        _isMobile = true;
        return MobileLoginView(
            onUserTappedLogInCallBack: login,
            usernameController: _usernameController,
            passwordController: _passwordController,
            usernameFocusNode: _usernameFocusNode,
            passwordFocusNode: _passwordFocusNode);
      } else {
        return DesktopLoginView(
            onUserTappedLogInCallBack: login,
            usernameController: _usernameController,
            passwordController: _passwordController,
            usernameFocusNode: _usernameFocusNode,
            passwordFocusNode: _passwordFocusNode);
      }
    });
  }
}
