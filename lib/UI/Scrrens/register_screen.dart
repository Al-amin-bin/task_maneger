import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:task_app/UI/controller/resister_screen_controller.dart';
import 'package:task_app/UI/widgets/screen_background.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/utils/urls.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ResisterScreenController _resisterScreenController =
      Get.find<ResisterScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Text("Join With Us",
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
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
              SizedBox(
                height: 18,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _firstNameTEController,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your first name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "First Name",
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _lastNameTEController,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your Last Name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Last Name",
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: _mobileTEController,
                validator: (String? value) {
                  String phone = value?.trim() ?? "";
                  RegExp regExp = RegExp(r"^(?:\+?88|0088)?01[15-9]\d{8}$");
                  if (regExp.hasMatch(phone) == false) {
                    return 'Enter your valid phone';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Mobile",
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextFormField(
                controller: _passwordTEController,
                validator: (String? value) {
                  if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                    return 'Enter your password more than 6 letters';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "password"),
              ),
              SizedBox(
                height: 24,
              ),
              GetBuilder<ResisterScreenController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.registrationInProgress == false,
                    replacement: CircularProgressIndicator(),
                    child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        style: ElevatedButton.styleFrom(),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )),
                  );
                }
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        children: [
                      TextSpan(text: "Have account ?"),
                      TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignUpButton)
                    ])),
              )
            ],
          ),
        ),
      )),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  void _onTapSignUpButton() {
    Navigator.pop(context);
  }

  Future<void> _registerUser() async {
    final bool isSuccess = await _resisterScreenController.resister(
        _emailTEController.text.trim(),
        _firstNameTEController.text.trim(),
        _lastNameTEController.text.trim(),
        _mobileTEController.text.trim(),
        _passwordTEController.text);

    if (isSuccess) {
      _clearTextField();
      showSnackBarMessage(context, "User Registered Successfully");
    } else {
      showSnackBarMessage(context, _resisterScreenController.errorMassage, true);
    }
  }

  void _clearTextField() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _firstNameTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
