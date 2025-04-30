import 'package:get/get.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/utils/urls.dart';

class ResetPasswordScreenController extends GetxController{
  bool _resetPasswordInProgress = false;
  get resetPasswordInProgress => _resetPasswordInProgress;

  String?  _errorMassage;
  get errorMassage => errorMassage;


  Future<bool> resetPassword(String email, String otp, String password) async {
    bool isSuccess = false;
    _resetPasswordInProgress = true;
    update();

    Map<String, dynamic> requestBody ={
      "email":email,
      "OTP": otp,
      "password":password
    };

    NetworkResponse response = await NetworkClient.postRequest(url: Urls.resetPasswordUrl,body: requestBody);
    if(response.isSuccess){
      isSuccess = true;
    }else{
      _errorMassage = response.errorMassage;
    }
    _resetPasswordInProgress = false;
   update();

   return isSuccess;
  }


}