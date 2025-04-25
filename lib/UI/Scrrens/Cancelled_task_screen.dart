import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/UI/widgets/task_card.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/task_list_model.dart';
import 'package:task_app/data/model/task_model.dart';
import 'package:task_app/data/utils/urls.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});


  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    getCancelledTask();
    super.initState();
  }
  bool _cancelTaskListInProgress = false;
  List<TaskModel> _cancelledList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _cancelTaskListInProgress == false,
        replacement: Center(child: CircularProgressIndicator(),),
        child: ListView.separated(
          itemCount: _cancelledList.length,
          itemBuilder: (context, index){
            return TaskCard(taskStatus: TaskStatus.cancelled, taskModel: _cancelledList[index], refreshList: getCancelledTask,);
          },
          separatorBuilder: (context, index){
            return SizedBox(height: 4,);
          }, ),
      ),
    );
  }

  Future<void> getCancelledTask()async{
    _cancelTaskListInProgress = true;
    setState(() {
    });
    NetworkResponse response = await NetworkClient.getRequest(url: Urls.cancelledListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _cancelledList = taskListModel.taskList;
    }else{
      showSnackBarMessage(context, response.errorMassage);
    }

    _cancelTaskListInProgress = false;
    setState(() {
    });

  }
}
