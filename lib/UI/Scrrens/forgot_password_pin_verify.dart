import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_app/UI/Scrrens/login_screen.dart';
import 'package:task_app/UI/Scrrens/reset_password_screen.dart';
import 'package:task_app/UI/widgets/screen_background.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/utils/urls.dart';

class ForgotPasswordPinVerifyScreen extends StatefulWidget {
  const ForgotPasswordPinVerifyScreen({super.key, required this.email});
  final String email;

  @override
  State<ForgotPasswordPinVerifyScreen> createState() => _ForgotPasswordPinVerifyScreenState();
}

class _ForgotPasswordPinVerifyScreenState extends State<ForgotPasswordPinVerifyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinTEController = TextEditingController();
  bool _verifyInProgress = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ScreenBackground(

          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60,),
                  Text("Pin Verification", style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text("A 6 digit verification pin will send your email Address",style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(height: 25,),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: _pinTEController,
                    validator:  (String? value){
                      if(value ==null|| value.isEmpty|| value.length <6 ?? true){
                        return "Enter A valid  password";
                      }
                      return null;
                    },
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {

                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    }, appContext: context,
                  ),
                  SizedBox(height: 24,),
                  Visibility(
                    visible: _verifyInProgress == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(onPressed: onTapElevatedButton,
                        style: ElevatedButton.styleFrom(

                        ),

                        child: Text("Verify")),
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
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (pre)=>false);

  }

  void onTapElevatedButton() {
    otpVerify(widget.email, _pinTEController.text.trim());
    

  }

  Future<void> otpVerify(String email, String otp)async{
    _verifyInProgress = true;
    setState(() {
    });
    NetworkResponse response =await NetworkClient.getRequest(url: Urls.verifyOtpUrl(email,otp));

    if(response.isSuccess){

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> ResetPasswordScreen(email: widget.email, otp: _pinTEController.text.trim(),)),(pre)=> false);
    }else{
      showSnackBarMessage(context, response.errorMassage);
    }
    _verifyInProgress = false;
    setState(() {
    });
  }
}
