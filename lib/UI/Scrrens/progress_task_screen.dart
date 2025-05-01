import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/UI/controller/progress_task_controller.dart';
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
  ProgressTaskController _progressTaskController = Get.find<ProgressTaskController>();
  @override
  void initState() {
    getProgressList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProgressTaskController>(
        builder: (controller) {
          return Visibility(
            visible: controller.progressListInProgress == false,
            replacement: Center(child: CircularProgressIndicator(),),
            child: ListView.separated(
                itemCount: controller.progressList.length,
                itemBuilder: (context, index){
                  return TaskCard(taskStatus: TaskStatus.progress, taskModel: controller.progressList[index], refreshList: getProgressList,);
                },
                separatorBuilder: (context, index){
                  return SizedBox(height: 4,);
                }, ),
          );
        }
      ),
    );
  }
  
  Future<void> getProgressList()async{
   bool isSuccess = await _progressTaskController.getProgressTaskList();
   if(!isSuccess){
     showSnackBarMessage(context, _progressTaskController.errorMassage!);
   }
    
  }
}
