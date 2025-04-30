import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/UI/Scrrens/forgot_password_pin_verify.dart';
import 'package:task_app/UI/Scrrens/login_screen.dart';
import 'package:task_app/UI/controller/reset_password_screen_controller.dart';
import 'package:task_app/UI/widgets/screen_background.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/utils/urls.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email, required this.otp});
  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final ResetPasswordScreenController _resetPasswordScreenController = Get.find<ResetPasswordScreenController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(

          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60,),
                  Text("Set Password", style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text("A 6 digit verification pin will send your email Address",style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(height: 25,),
                  TextFormField(
                    validator:(String? value) {
                      if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                        return 'Enter your password more than 6 letters';
                      }
                      return null;
                    },

                    controller: _passwordTEController,
                    decoration: InputDecoration(
                      hintText: "password",
                    ),
                  ),
                  SizedBox(height: 24,),
                  TextFormField(
                    validator: (String? value){
                      if(_passwordTEController.text != _confirmPasswordTEController.text){
                        return "Not Match Password";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: _confirmPasswordTEController,
                    decoration: InputDecoration(
                      hintText: "Confirm password",
                    ),
                  ),
                  SizedBox(height: 24,),
                  GetBuilder<ResetPasswordScreenController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.resetPasswordInProgress == false,
                        replacement: Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(onPressed: onTapElevatedButton,
                            style: ElevatedButton.styleFrom(

                            ),

                            child: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
                      );
                    }
                  ),
                  SizedBox(height: 24,),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                            children: [
                              TextSpan(
                                  text: "Have account? "
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
                        )),
                  )

                ],
              ),
            ),
          )
      ),
    );
  }
 void _onTapSignUpButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (predicate)=> false);
 }
 void onTapElevatedButton(){
    if(_formKey.currentState!.validate()){
      resetPassword(widget.email, widget.otp, _passwordTEController.text.trim());
    }
 }

  Future<void> resetPassword(String email, String otp, String password) async{

    bool isSuccess = await _resetPasswordScreenController.resetPassword(widget.email, widget.otp, _passwordTEController.text);

    if(isSuccess){
     Get.offAll(LoginScreen());
      showSnackBarMessage(context, "successfully reset password");
    }else{
      showSnackBarMessage(context, _resetPasswordScreenController.errorMassage);
    }

  }
 @override
  void dispose() {
    _passwordTEController.dispose();
    super.dispose();
  }

}
