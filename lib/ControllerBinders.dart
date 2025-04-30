import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_app/UI/controller/add_new_task_screen_controller.dart';
import 'package:task_app/UI/controller/loginController.dart';
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
    // TODO: implement dependencies
  }

}