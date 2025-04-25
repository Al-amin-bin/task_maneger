

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_app/UI/Scrrens/login_screen.dart';
import 'package:task_app/UI/Scrrens/main_bottom_nav_screen.dart';
import 'package:task_app/UI/controller/authController.dart';
import 'package:task_app/UI/utils/asset_path.dart';
import 'package:task_app/UI/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen()async{
    final bool isLogin = await AuthController.checkIfUserLogeedin();
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>isLogin ? MainBottomNavScreen():  LoginScreen()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
            child: Center(child: SvgPicture.asset(AssetsPath.logoSvg))
        ),
    );
  }
}
