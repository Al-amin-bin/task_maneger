import 'package:flutter/material.dart';
import 'package:task_app/UI/utils/date_format.dart';
import 'package:task_app/UI/widgets/showSnacbar.dart';
import 'package:task_app/data/Service/network_client.dart';

import 'package:task_app/data/model/task_model.dart';
import 'package:task_app/data/utils/urls.dart';

enum TaskStatus{
  sNew,
  progress,
  completed,
  cancelled,
}

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskStatus, required this.taskModel, required this.refreshList,
  });
  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String date(String date) => DateFormatClass.DateFormate(date);
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
            Text(widget.taskModel.description),
            Text(date(widget.taskModel.createdDate)),
            Row(
              children: [
                Chip(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,),
                    child: Text(widget.taskModel.status,style:TextStyle(color: Colors.white),),
                  ),
                  backgroundColor: _getTaskStatusColor(),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),


                ),
                Spacer(),
                IconButton(onPressed: _deleteTask, icon:Icon(Icons.delete)),
                IconButton(onPressed: _showUpdateStatusDialog, icon:Icon(Icons.edit))
              ],
            )
          ],
        ),
      ),
    );

  }

  Color _getTaskStatusColor(){
    late Color color;
    switch(widget.taskStatus){
      case TaskStatus.sNew:
        color = Colors.blue;

      case TaskStatus.progress:
        color = Colors.pink;

      case TaskStatus.completed:
          color = Colors.green;

      case TaskStatus.cancelled:
          color = Colors.red;


    }
    return color;

  }

 void  _showUpdateStatusDialog(){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Update Status"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("New"),
            trailing: isSelected("New")? const Icon(Icons.done): null,
            onTap: (){
              _popDialog();
              if(isSelected("New")) return;
              _changeTaskStatus("New");
            },
          ),
          ListTile(
            onTap: (){
              _popDialog();
              if(isSelected("Progress")) return;
              _changeTaskStatus("Progress");
            },
            title: Text("Progress"),
            trailing: isSelected("Progress")? const Icon(Icons.done): null,
          ),
          ListTile(
            onTap: (){
              _popDialog();
              if(isSelected("Completed")) return;
              _changeTaskStatus("Completed");
            },
            title: Text("Completed"),
            trailing: isSelected("Completed")? const Icon(Icons.done): null,
          ),
          ListTile(
            onTap: (){
              _popDialog();
              if(isSelected("Canceled")) return;
              _changeTaskStatus("Cancelled");
            },
            title: Text("Cancelled"),
            trailing: isSelected("Cancelled")? const Icon(Icons.done): null,
          ),
        ],
      ),
    );
  });


  }
  void _popDialog(){
    Navigator.pop(context);
  }
  bool isSelected(String status) => widget.taskModel.status == status;

  Future<void> _changeTaskStatus(String status)async{
    _inProgress = true;
    setState(() {
    });
    NetworkResponse response = await NetworkClient.getRequest(url: Urls.updateTaskStatusUrl(widget.taskModel.id, status));
    if(response.isSuccess){
      widget.refreshList;
      setState(() {
      });

    }else{
      showSnackBarMessage(context, response.errorMassage);
    }
    _inProgress = false;
    setState(() {
    });
  }
  Future<void> _deleteTask()async{
    _inProgress = true;
    setState(() {
    });
    NetworkResponse response =await NetworkClient.getRequest(url: Urls.deleteTaskUrl(widget.taskModel.id));
    if(response.isSuccess){
      widget.refreshList;

    }else{
      setState(() {

      });
      showSnackBarMessage(context, response.errorMassage);
    }
  }
}

