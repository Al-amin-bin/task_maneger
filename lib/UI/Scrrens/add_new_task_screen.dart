import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_app/UI/Scrrens/main_bottom_nav_screen.dart';
import 'package:task_app/UI/Scrrens/new_task_screen.dart';
import 'package:task_app/UI/controller/add_new_task_screen_controller.dart';
import 'package:task_app/UI/widgets/screen_background.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/utils/urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController= TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 final AddNewTaskController _addNewTaskController = Get.find<AddNewTaskController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60,),
                  Text("Add New Task", style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 12,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _subjectTEController,
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return " Enter a New Subject";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Subject",
                    ),
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _descriptionTEController,
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "Please Enter New Description";
                      }
                      return null;
                    },
                    maxLines: 6,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      hintText: "Description",
                    ),
                  ),
                  SizedBox(height: 24,),
                  GetBuilder<AddNewTaskController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.addNewTaskInProgress == false,
                        replacement: Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(onPressed: _onTapLoginButton,
                            style: ElevatedButton.styleFrom(

                            ),

                            child: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
                      );
                    }
                  ),
                ],
              ),
            ),
          ) ),
    );
  }

  void _onTapLoginButton() {
    if(_formKey.currentState!.validate()){
        _createNewTask();
    }
  }

  Future<void> _createNewTask()async{

   final bool isSuccess = await _addNewTaskController.addNewTask(_subjectTEController.text.trim(), _descriptionTEController.text.trim());
    if(isSuccess){
      Get.offAll(MainBottomNavScreen());
      showSnackBarMessage(context, "A New Task Create Successfully");
      _clearTextField();

    }else{
      showSnackBarMessage(context, _addNewTaskController.errorMassage);
    }


  }
  void _clearTextField(){
    _subjectTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
