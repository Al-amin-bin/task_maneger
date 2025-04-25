import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_app/UI/Scrrens/forgot_password_pin_verify.dart';
import 'package:task_app/UI/widgets/screen_background.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/data/Service/network_client.dart';

import '../../data/utils/urls.dart';

class ForgotPasswordVerifyEmail extends StatefulWidget {
  const ForgotPasswordVerifyEmail({super.key});

  @override
  State<ForgotPasswordVerifyEmail> createState() => _ForgotPasswordVerifyEmailState();
}

class _ForgotPasswordVerifyEmailState extends State<ForgotPasswordVerifyEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
   bool _emailVerifyButtonInProgress = false;
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
                  Text("Your Email Address", style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text("A 6 digit verification pin will send your email Address",style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(height: 25,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
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
                  Visibility(
                    visible: _emailVerifyButtonInProgress == false,
                      replacement: Center(child: CircularProgressIndicator(),),
                      child: SizedBox(height: 24,)),
                  ElevatedButton(onPressed: onTapElevatedButton,
                      style: ElevatedButton.styleFrom(

                      ),

                      child: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
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
    Navigator.pop(context);
 }
 void onTapElevatedButton(){

    if(_formKey.currentState!.validate()){
      _emailVerify();


    }

 }

 Future<void>_emailVerify() async {

    _emailVerifyButtonInProgress = true;
    setState(() {
    });
    NetworkResponse response =await NetworkClient.getRequest(url: Urls.recoverVerifyEmail(_emailTEController.text));
    _emailVerifyButtonInProgress= false;
    if(response.isSuccess){
      showSnackBarMessage(context, "Please Check Your Email 6 digit Password");
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordPinVerifyScreen(email: _emailTEController.text,)));
    }else{
      showSnackBarMessage(context, response.errorMassage);
    }

 }


 @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

}
