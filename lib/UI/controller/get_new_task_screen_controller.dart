import 'package:get/get.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/task_list_model.dart';
import 'package:task_app/data/model/task_model.dart';
import 'package:task_app/data/utils/urls.dart';

class GetNewTaskScreenController extends GetxController{
  bool _getNewTaskListInProgress = false;
  bool get getNewTaskListInProgress => _getNewTaskListInProgress;

  String? _errorMassage;
  String? get errorMassage =>_errorMassage;

  List<TaskModel> _newTaskList = [];
  List<TaskModel> get newTaskList => _newTaskList;


  Future<bool> getNewTask () async {
    bool isSuccess = false;
    _getNewTaskListInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(url: Urls.newTaskListUrl);
    if(response.isSuccess){
      isSuccess = true;
      TaskListModel taskListModel = TaskListModel.fromJson(response.data! ?? {});
      _newTaskList = taskListModel.taskList;
    }else{
      _errorMassage = response.errorMassage;
    }
   _getNewTaskListInProgress = false;
    update();
    return isSuccess;


  }
}