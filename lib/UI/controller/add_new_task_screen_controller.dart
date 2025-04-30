import 'package:get/get.dart';
import 'package:task_app/UI/Scrrens/main_bottom_nav_screen.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/utils/urls.dart';

class AddNewTaskController extends GetxController{
  bool _addNewTaskInProgress = false;

  get addNewTaskInProgress => _addNewTaskInProgress;

  String? _errorMassage ;
  get errorMassage => _errorMassage;

  Future<bool> addNewTask(String title, String description) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title":title,
      "description": description,
      "status":"New"
    };
    NetworkResponse response =await NetworkClient.postRequest(url: Urls.createTaskUrl,body: requestBody);
    _addNewTaskInProgress = false;
    update();

    if(response.statusCode == 200){
      isSuccess = true;

    }else{
      _errorMassage = response.errorMassage;
    }

    return isSuccess;

  }

}