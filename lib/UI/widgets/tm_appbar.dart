import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_app/UI/Scrrens/login_screen.dart';
import 'package:task_app/UI/Scrrens/update_profile_screen.dart';
import 'package:task_app/UI/controller/authController.dart';


class TmAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TmAppBar({
    super.key,  this.fromUpdateProfileScreen,
  });
  final bool? fromUpdateProfileScreen;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor:Colors.green,
      title: GestureDetector(
        onTap: (){
          if(fromUpdateProfileScreen ?? false){
            return;
          }

          _onTapInAppBar(context);},
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:   shouldImage(AuthController.userModel!.photo) ? MemoryImage(base64Decode(AuthController.userModel?.photo?? '')): null,

            ),
            SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AuthController.userModel!.fullName,style: textTheme.bodyMedium?.copyWith(color: Colors.white),),
                  Text(AuthController.userModel!.email,style: textTheme.bodySmall?.copyWith(color: Colors.white),)
                ],
              ),
            ),
            IconButton(onPressed: (){
              AuthController.clearUserData();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (pre)=> false);
            }, icon: Icon(Icons.logout))
          ],
        ),
      ),
    );


  }
  bool shouldImage(String image){
      
    return AuthController.userModel!.photo != null && AuthController.userModel!.photo.isNotEmpty;
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  _onTapInAppBar(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfileScreen()));
  }
}