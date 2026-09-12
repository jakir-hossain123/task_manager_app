import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/models/user_model.dart';
import 'package:task_manager_app/screens/main_nav_screen.dart';
import 'package:task_manager_app/screens/sign_up_screen.dart';
import 'package:task_manager_app/screens/splash_screen.dart';
import 'package:task_manager_app/service/api_caller.dart';
import 'package:task_manager_app/utils/urls.dart';
import 'package:task_manager_app/widgets/screen_bg.dart';
import 'package:task_manager_app/widgets/tm_app_bar.dart';

import '../models/api_response.dart';
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  onTapSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBG(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 150,),
              Text('Add new task',style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 25,),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "Title"
                ),
              ),
              const SizedBox(height: 25,),
              TextFormField(
                controller: descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: "Description"
                ),
              ),

              const SizedBox(height: 20,),

              FilledButton(onPressed: () async {
                final ApiResponse response =  await ApiCaller.postRequest(url:
                TMUrls.addNewTask,
                    body:{
                      "title":titleController.text,
                      "description": descriptionController.text,
                      "status":"New"
                    }
                );
                if(response.isSuccess ){

                  Navigator.pushReplacement(context, MaterialPageRoute(builder:
                      (context)=> MainNavScreen()));




                }
              }, child: Icon(Icons.arrow_right_alt_outlined)),

            ],
          ),
        ),
      ),
    );
  }
}
