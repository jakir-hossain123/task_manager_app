import 'package:flutter/material.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/screens/login_screen.dart';
import 'package:task_manager_app/screens/main_nav_screen.dart';
import 'package:task_manager_app/utils/asset_path.dart';

import '../widgets/screen_bg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _State();
}

class _State extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToNextScreen();
  }

  Future moveToNextScreen () async {
    await Future.delayed(Duration(seconds: 3));
    AuthController.getUserData();
    bool isLogin = await AuthController.isUserLogin();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
    isLogin? MainNavScreen(): LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ScreenBG(child: Center(child: Image.asset(
            width: 300,
            height: 300,
            AssetPath.logo)),),
    );
  }
}

