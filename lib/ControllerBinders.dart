import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_app/UI/controller/add_new_task_screen_controller.dart';
import 'package:task_app/UI/controller/cancelled_task_controller.dart';
import 'package:task_app/UI/controller/completed_taskList_controller.dart';
import 'package:task_app/UI/controller/get_new_task_screen_controller.dart';
import 'package:task_app/UI/controller/loginController.dart';
import 'package:task_app/UI/controller/progress_task_controller.dart';
import 'package:task_app/UI/controller/reset_password_screen_controller.dart';
import 'package:task_app/UI/controller/resister_screen_controller.dart';
import 'package:task_app/UI/controller/update_profile_screen_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {

    Get.put(LoginController());
    Get.put(AddNewTaskController());
    Get.put(ResisterScreenController());
    Get.put(UpdateProfileScreenController());
    Get.put(ResetPasswordScreenController());
    Get.put(GetNewTaskScreenController());
    Get.put(CancelledTaskController());
    Get.put(CompletedTaskListController());
    Get.put(ProgressTaskController());
    // TODO: implement dependencies
  }

}