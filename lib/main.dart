import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/splash_screen.dart';

void main() {
  runApp(const TaskManager());
}

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.green,
            selectionColor: Colors.greenAccent,
            selectionHandleColor: Colors.green,
          ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600

          )
        ),

        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey
          ),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none
          ),
        ),
        
        
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 13),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8)

            )
          ),
          
        )

      ),
      home: SplashScreen(),
    );
  }
}
