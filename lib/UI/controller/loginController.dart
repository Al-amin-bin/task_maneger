import 'package:get/get.dart';
import 'package:task_app/UI/controller/authController.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/loginModel.dart';
import 'package:task_app/data/utils/urls.dart';

class LoginController extends GetxController{
  bool _loginInProgress = false;
   bool get loginInProgress => _loginInProgress;

   String? _errorMessage;
   String? get errorMessage => _errorMessage;


   Future<bool> login(String email, String password) async {
     bool isSuccess = false;

     _loginInProgress = true;
      update();
     Map<String, dynamic> requestBody = {
       "email":email,
       "password":password,

     };
     NetworkResponse response =await NetworkClient.postRequest(url: Urls.loginUrl, body: requestBody);

     if(response.isSuccess){
       LoginModel loginModel = LoginModel.fromJson(response.data!);
       AuthController.saveUserInformation(loginModel.token, loginModel.userModel);
       isSuccess = true;
       _errorMessage = null;

     }else{
       _errorMessage = response.errorMassage;
     }
     _loginInProgress = false;
     update();
     return isSuccess;


   }

}