import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/utils/urls.dart';

class UpdateProfileScreenController extends GetxController {
  bool _updateProfileInProgress = false;
  get updateProfileInProgress => _updateProfileInProgress;

  String? _errorMassage ;
  get errorMassage => _errorMassage;


  Future<bool> updateProfile(String email, String firstName, String lastName, String mobile, String? password, XFile? photo)async{
    bool isSuccess = false;

    _updateProfileInProgress= true;
    update();
    Map<String, dynamic> requestBody= {
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,

    };

    if(password != null){
      //requestBody["password"] = password;
    }
    if(photo != null){
      List<int> imageByte = await photo!.readAsBytes();
      String encodeImage = base64Encode(imageByte);
      requestBody["photo"]= encodeImage;
    }

    NetworkResponse response =await NetworkClient.postRequest(url: Urls.profileUpdate, body: requestBody);
    _updateProfileInProgress = false;
    update();

    if(response.isSuccess){
      isSuccess = true;

    }else{
      _errorMassage = response.errorMassage;
    }
    return isSuccess;
  }

}