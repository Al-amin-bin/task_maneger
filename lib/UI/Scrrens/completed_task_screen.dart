import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/UI/controller/completed_taskList_controller.dart';
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
  CompletedTaskListController _completedTaskListController = Get.find<CompletedTaskListController>();
  @override
  void initState() {
    getCompletedTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompletedTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: controller.completedTaskListInProgress == false,
            replacement: Center(child: CircularProgressIndicator(),),
            child: ListView.separated(
              itemCount: controller.completedTaskList.length,
              itemBuilder: (context, index){
                return TaskCard(taskStatus: TaskStatus.completed, taskModel: controller.completedTaskList[index], refreshList: getCompletedTaskList,);
              },
              separatorBuilder: (context, index){
                return SizedBox(height: 4,);
              }, ),
          );
        }
      ),
    );
  }
  
  Future<void> getCompletedTaskList () async{

    bool isSuccess = await _completedTaskListController.getCompletedTaskList();

    if(!isSuccess){
      showSnackBarMessage(context, _completedTaskListController.errorMassage!);
    }

  }
  
}
