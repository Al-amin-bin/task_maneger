import 'package:get/get.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/utils/urls.dart';

class ResisterScreenController extends GetxController{
  bool _registrationInProgress = false;
  get registrationInProgress => _registrationInProgress;

  String? _errorMassage ;
  get errorMassage => _errorMassage;



  Future<bool>resister(String email, String firstName, String lastName, String mobile, String password) async {
      bool isSuccess = false;
    _registrationInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,
      "password":password,
    };

    NetworkResponse response =await NetworkClient.postRequest(url: Urls.registerUrl,body: requestBody);
    _registrationInProgress = false;
    update();

    if(response.isSuccess){
      isSuccess = true;
    }else{
      _errorMassage = response.errorMassage;
    }
    return isSuccess;
  }


}