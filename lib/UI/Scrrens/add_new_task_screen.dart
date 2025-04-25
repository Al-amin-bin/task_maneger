import 'package:flutter/material.dart';
import 'package:task_app/UI/Scrrens/main_bottom_nav_screen.dart';
import 'package:task_app/UI/Scrrens/new_task_screen.dart';
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
  bool _addNewTaskButtonInProgress = false;
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
                  Visibility(
                    visible: _addNewTaskButtonInProgress == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(onPressed: _onTapLoginButton,
                        style: ElevatedButton.styleFrom(

                        ),

                        child: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
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
    _addNewTaskButtonInProgress = true;
    Map<String, dynamic> requestBody = {
      "title":_subjectTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status":"New"
    };
    NetworkResponse response =await NetworkClient.postRequest(url: Urls.createTaskUrl,body: requestBody);
    _addNewTaskButtonInProgress = false;

    if(response.statusCode == 200){
      _clearTextField();
      showSnackBarMessage(context, "New Task Create Successfully");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainBottomNavScreen()), (pre)=>false);
    }else{
      showSnackBarMessage(context, response.errorMassage);
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
