import 'package:flutter/material.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/UI/widgets/task_card.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/task_list_model.dart';
import 'package:task_app/data/model/task_model.dart';
import 'package:task_app/data/utils/urls.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  List<TaskModel> _progressList = [];
  bool _progressListInProgress = false;
  @override
  void initState() {
    getProgressList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemCount: _progressList.length,
          itemBuilder: (context, index){
            return TaskCard(taskStatus: TaskStatus.progress, taskModel: _progressList[index], refreshList: getProgressList,);
          },
          separatorBuilder: (context, index){
            return SizedBox(height: 4,);
          }, ),
    );
  }
  
  Future<void> getProgressList()async{
    _progressListInProgress = true;
    setState(() {
    });
    NetworkResponse response =await NetworkClient.getRequest(url: Urls.progressListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _progressList = taskListModel.taskList;
    }else{
      showSnackBarMessage(context, response.errorMassage);
    }
    _progressListInProgress = false;
    setState(() {
    });
    
  }
}
