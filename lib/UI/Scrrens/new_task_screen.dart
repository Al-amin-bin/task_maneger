import 'package:flutter/material.dart';
import 'package:task_app/UI/Scrrens/add_new_task_screen.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/UI/widgets/summary_card.dart';
import 'package:task_app/UI/widgets/task_card.dart';
import 'package:task_app/data/Service/network_client.dart';
import 'package:task_app/data/model/task_list_model.dart';
import 'package:task_app/data/model/task_model.dart';
import 'package:task_app/data/model/task_status_count_list_model.dart';
import 'package:task_app/data/model/task_status_count_model.dart';
import 'package:task_app/data/utils/urls.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getAllStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  bool getAllTaskListProgress = false;
  List<TaskModel> _newTaskList = [];
  @override
  void initState() {
    getAllTaskStatusCount();
    getAllNewTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: getAllStatusCountInProgress == false,
                replacement: Center(child: CircularProgressIndicator(),),
                child: _buildSummarySection()),
            Visibility(
              visible: getAllTaskListProgress == false,
              replacement: SizedBox(height:300,child: Center(child: CircularProgressIndicator(),)),
              child: ListView.separated(
                shrinkWrap: true,
                  primary: false,
                  itemCount: _newTaskList.length,
                  itemBuilder: (context,index){
                return TaskCard(taskStatus: TaskStatus.sNew,taskModel: _newTaskList[index], refreshList:   getAllNewTaskList,);
              }, separatorBuilder: (context,index){
                return SizedBox(height: 12,);
              }),
            )
        
        
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _onTapAddNewButton,child: Icon(Icons.add),),
    );
  }
  void _onTapAddNewButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewTaskScreen()));
  }

  Future<void> getAllTaskStatusCount() async {
    getAllStatusCountInProgress = true;
    setState(() {
    });
    NetworkResponse response = await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);
    if(response.isSuccess){
      TaskStatusCountListModel taskStatusCountListModel = TaskStatusCountListModel.fromJson(response.data! ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    }else{
      showSnackBarMessage(context, response.errorMassage,true);
    }
    getAllStatusCountInProgress = false;
    setState(() {
    });

  }
  Future<void> getAllNewTaskList() async {
    getAllTaskListProgress = true;
    setState(() {
    });
    NetworkResponse response = await NetworkClient.getRequest(url: Urls.newTaskListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data! ?? {});
      _newTaskList = taskListModel.taskList;
    }else{
      showSnackBarMessage(context, response.errorMassage,true);
    }
    getAllTaskListProgress = false;
    setState(() {
    });

  }


  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _taskStatusCountList.length,
          itemBuilder: (context, index){
            return Row(
              children: [
                SummaryCard(
                  title: _taskStatusCountList[index].status,
                  count: _taskStatusCountList[index].count),

              ],
            );
          },

        ),
      ),
    );
  }
}







