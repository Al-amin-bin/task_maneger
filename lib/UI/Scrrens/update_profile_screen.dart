import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_app/UI/controller/authController.dart';
import 'package:task_app/UI/widgets/screen_background.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/UI/widgets/tm_appbar.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/userModel.dart';

import '../../data/utils/urls.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  bool _updateProfileInProgress = false;
  XFile? _pickedImage;

  @override
  void initState() {
    UserModel userModel =AuthController.userModel!;
    super.initState();
    _emailTEController.text = userModel.email;
    _firstNameTEController.text = userModel.firstName;
    _lastNameTEController.text = userModel.lastName;
    _mobileTEController.text = userModel.mobile;
  }


  Future<void> _onTapPhotoPicker() async{
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _pickedImage = image;
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(fromUpdateProfileScreen: true,),
      body: ScreenBackground(
          child:Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60,),
                  Text("Update Profile", style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 25,),
                  _buildPhotoPickerWidgets(),
                  SizedBox(height: 8,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    enabled: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      String email = value?.trim() ?? '';
                      if (EmailValidator.validate(email) == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(height: 18,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _firstNameTEController,
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Enter valid First Name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "First Name",
                    ),
                  ),
                  SizedBox(height: 18,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Please Enter Last name";
                      }
                      return null;
                    },
                    controller: _lastNameTEController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                    ),
                  ),
                  SizedBox(height: 18,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: _mobileTEController,
                    validator: (String? value) {
                      String phone = value?.trim() ?? '';
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

                  SizedBox(height: 18,),
                  TextFormField(
                    controller: _passwordTEController,
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: "password"
                    ),
                  ),
                  SizedBox(height: 24,),
                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: Center(child:  CircularProgressIndicator(),),
                    child: ElevatedButton(onPressed: (){

                      if(_formKey.currentState!.validate()){
                        updateProfile();

                      }
                    },
                        style: ElevatedButton.styleFrom(

                        ),

                        child: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
                  ),
                

                ],
              ),
            ),
          )),
    );
  }
  void _onTapSignUpButton(){
        Navigator.pop(context);
  }
  Widget _buildPhotoPickerWidgets(){
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width:  80,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8))
              ), alignment: Alignment.center,
            child: const Text(
              'Photo',
              style: TextStyle(color: Colors.white),
            ),

            ),
            
            const SizedBox(width: 8),
            Text(_pickedImage?.name ?? 'Select your photo')
          ],
        ),

      ),
    );
  }

  Future<void> updateProfile() async {
    _updateProfileInProgress= true;
    Map<String, dynamic> requestBody= {
      "email":_emailTEController.text.trim(),
      "firstName":_firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text.trim(),
      "mobile":_mobileTEController.text.trim(),

    };

    if(_passwordTEController.text.isNotEmpty){
      requestBody["password"] = _passwordTEController.text;
    }
    if(_pickedImage != null){
      List<int> imageByte = await _pickedImage!.readAsBytes();
      String encodeImage = base64Encode(imageByte);
      requestBody["photo"]= encodeImage;
    }

    NetworkResponse response =await NetworkClient.postRequest(url: Urls.profileUpdate, body: requestBody);
    _updateProfileInProgress = false;

    if(response.isSuccess){
      _passwordTEController.clear();
      showSnackBarMessage(context, "Your Profile update Successfully");

    }else{
      showSnackBarMessage(context, response.errorMassage);
    }
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
