import 'package:flutter/material.dart';
import 'package:task_app/UI/Scrrens/Cancelled_task_screen.dart';
import 'package:task_app/UI/Scrrens/completed_task_screen.dart';
import 'package:task_app/UI/Scrrens/new_task_screen.dart';
import 'package:task_app/UI/Scrrens/progress_task_screen.dart';
import 'package:task_app/UI/widgets/tm_appbar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screen=[

    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: TmAppBar(),
      body: _screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
          onDestinationSelected: (index){
          _selectedIndex = index;
          setState(() {

          });
          },
          destinations: [
        NavigationDestination(icon: Icon(Icons.new_label), label: "New Task"),
        NavigationDestination(icon: Icon(Icons.ac_unit), label: "Progress"),
        NavigationDestination(icon: Icon(Icons.done), label: "Complete"),
        NavigationDestination(icon: Icon(Icons.cancel_outlined), label: "Cancel"),
      ]),
    );
  }
}


