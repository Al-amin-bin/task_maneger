import 'package:get/get.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/task_list_model.dart';
import 'package:task_app/data/model/task_model.dart';
import 'package:task_app/data/utils/urls.dart';

class CompletedTaskListController extends GetxController{
  bool _completedTaskListInProgress = false;
  bool get completedTaskListInProgress => _completedTaskListInProgress;
  String? _errorMassage ;
  String? get errorMassage => _errorMassage;

  List<TaskModel> _completedTaskList =[];
  List<TaskModel> get completedTaskList => _completedTaskList;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;

    _completedTaskListInProgress = true;
    update();
    NetworkResponse response = await NetworkClient.getRequest(url: Urls.completedListUrl);
    if(response.isSuccess){
      isSuccess = true;
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _completedTaskList = taskListModel.taskList;
    }else{
     _errorMassage = response.errorMassage;
    }
    _completedTaskListInProgress = false;
    update();
    return isSuccess;
  }
}