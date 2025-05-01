import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:task_app/UI/controller/cancelled_task_controller.dart';
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
  CancelledTaskController _cancelledTaskController = Get.find<CancelledTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CancelledTaskController>(
        builder: (controller) {
          return Visibility(
            visible: controller.cancelledTaskInProgress == false,
            replacement: Center(child: CircularProgressIndicator(),),
            child: ListView.separated(
              itemCount: controller.cancelledTaskList.length,
              itemBuilder: (context, index){
                return TaskCard(taskStatus: TaskStatus.cancelled, taskModel: controller.cancelledTaskList[index], refreshList: getCancelledTask,);
              },
              separatorBuilder: (context, index){
                return SizedBox(height: 4,);
              }, ),
          );
        }
      ),
    );
  }

  Future<void> getCancelledTask()async{

    bool isSuccess = await _cancelledTaskController.geCancelledTask();

    if(!isSuccess){
      showSnackBarMessage(context, _cancelledTaskController.errorMassage!);
    }

  }
}
