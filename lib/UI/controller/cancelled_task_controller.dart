import 'package:get/get.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/task_list_model.dart';
import 'package:task_app/data/model/task_model.dart';
import 'package:task_app/data/utils/urls.dart';

class  CancelledTaskController extends GetxController{
  bool _cancelledTaskInProgress = false;
  bool get cancelledTaskInProgress => _cancelledTaskInProgress;

  String? _errorMassage ;
  String? get errorMassage => _errorMassage;
  List<TaskModel> _cancelledTaskList = [];
  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  Future<bool> geCancelledTask() async {
    bool isSuccess = false;

    _cancelledTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(url: Urls.cancelledListUrl);
    if(response.isSuccess){
      isSuccess = true;
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _cancelledTaskList = taskListModel.taskList;
    }else{
      _errorMassage = response.errorMassage;
    }

    _cancelledTaskInProgress= false;
    update();
    return isSuccess;

  }
}