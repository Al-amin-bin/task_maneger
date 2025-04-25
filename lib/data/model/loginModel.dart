import 'package:task_app/data/model/userModel.dart';

class LoginModel {

  late String status ;
  late String token ;
  late UserModel userModel;


  LoginModel.fromJson(Map<String, dynamic>jsonData){
    status =jsonData["status"] ?? '';
    token =jsonData["token"]?? '';
    userModel =UserModel.fromJson(jsonData["data"] ?? {});
  }


}