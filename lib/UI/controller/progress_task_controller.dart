import 'package:get/get.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/task_list_model.dart';
import 'package:task_app/data/model/task_model.dart';
import 'package:task_app/data/utils/urls.dart';

class ProgressTaskController extends GetxController{
  bool _progressListInProgress = false;
  bool get progressListInProgress => _progressListInProgress;
  String? _errorMassage ;
  String? get errorMassage => _errorMassage;
  List<TaskModel> _progressList = [] ;
  List<TaskModel> get progressList => _progressList;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;

    _progressListInProgress = true;
    update();

    NetworkResponse response =await NetworkClient.getRequest(url: Urls.progressListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _progressList = taskListModel.taskList;
    }else{
      _errorMassage = response.errorMassage;
    }
    _progressListInProgress = false;
    update();
    return isSuccess;
  }
}