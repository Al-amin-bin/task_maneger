import 'package:flutter/material.dart';
import 'package:task_app/UI/Scrrens/splash_screen.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:  TaskApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),

          border: _getZeroBorder()
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade800,
              fixedSize: Size.fromWidth(double.maxFinite),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              )
          )
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          )
        )
      ),

      home: SplashScreen(),
    );
  }
  OutlineInputBorder _getZeroBorder(){
   return OutlineInputBorder(
       borderSide: BorderSide.none
   );
  }
}
