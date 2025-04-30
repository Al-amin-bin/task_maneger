import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_app/UI/Scrrens/forgot_passwor_verify_email.dart';
import 'package:task_app/UI/Scrrens/main_bottom_nav_screen.dart';
import 'package:task_app/UI/Scrrens/register_screen.dart';
import 'package:task_app/UI/controller/authController.dart';
import 'package:task_app/UI/controller/loginController.dart';
import 'package:task_app/UI/widgets/screen_background.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/loginModel.dart';

import '../../data/utils/urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(

          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60,),
                  Text("Get Started With", style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 25,),

                  TextFormField(
                    controller: _emailTEController,
                    validator: (String? value) {
                      String email = value?.trim() ?? '';
                      if (EmailValidator.validate(email) == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(height: 18,),
                  TextFormField(
                    controller: _passwordTEController,
                    validator: (String? value){
                      if(value?.isEmpty ?? true){
                        return "Enter A valid  password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "password"
                    ),
                  ),
                  SizedBox(height: 24,),
                  GetBuilder<LoginController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.loginInProgress == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(onPressed: _onTapLoginButton,
                            style: ElevatedButton.styleFrom(

                            ),

                            child: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
                      );
                    }
                  ),
                  SizedBox(height: 24,),
                  Center(
                    child: Column(

                      children: [
                        TextButton(onPressed: _onTapForgotButton,

                            child: Text("Forgot Account ?")),
                        RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),
                              children: [
                                TextSpan(
                                  text: "Don't have account ?"
                                ),
                                TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTapSignUpButton
                                )
                              ]
                            ))

                      ],
                    ),
                  )

                ],
              ),
            ),
          )
      ),
    );
  }
  void _onTapLoginButton(){
    if(_formKey.currentState!.validate()){
      _login();
    }

    //
  }
  void _onTapSignUpButton(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
  }

  void _onTapForgotButton(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordVerifyEmail()));
  }

  Future<void> _login()async {
    final bool isSuccess =  await _loginController.login(_emailTEController.text.trim(), _passwordTEController.text);
  if(isSuccess){
    Get.offAll(MainBottomNavScreen());

  }else{
    showSnackBarMessage(context, _loginController.errorMessage!);
  }


  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}

