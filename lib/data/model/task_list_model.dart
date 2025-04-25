import 'package:task_app/data/model/task_model.dart';

class TaskListModel{
  late String status;
  late List<TaskModel> taskList ;

  TaskListModel.fromJson(Map<String, dynamic> jsonData){
    status = jsonData["status"];
    if(jsonData['data'] != null){
      List<TaskModel> list = [];
      for(Map<String, dynamic> data  in jsonData['data']){
        list.add(TaskModel.fromJson(data));

      }
      taskList = list;
    }else {
      taskList = [];
    }
  }
}