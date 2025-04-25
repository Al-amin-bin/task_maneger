import 'package:flutter/material.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/UI/widgets/task_card.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/task_list_model.dart';
import 'package:task_app/data/model/task_model.dart';
import 'package:task_app/data/utils/urls.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskModel> _completedTaskList = [];
  bool _completedTaskListInProgress = false;
  @override
  void initState() {
    getCompletedTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _completedTaskListInProgress == false,
        replacement: Center(child: CircularProgressIndicator(),),
        child: ListView.separated(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index){
            return TaskCard(taskStatus: TaskStatus.completed, taskModel: _completedTaskList[index], refreshList: getCompletedTaskList,);
          },
          separatorBuilder: (context, index){
            return SizedBox(height: 4,);
          }, ),
      ),
    );
  }
  
  Future<void> getCompletedTaskList () async{
    _completedTaskListInProgress = true;
    setState(() {
    });
    NetworkResponse response = await NetworkClient.getRequest(url: Urls.completedListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _completedTaskList = taskListModel.taskList;
    }else{
      showSnackBarMessage(context, response.errorMassage);
    }
    _completedTaskListInProgress = false;
    setState(() {

    });
  }
  
}
