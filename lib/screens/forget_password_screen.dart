import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/models/user_model.dart';
import 'package:task_manager_app/screens/login_screen.dart';
import 'package:task_manager_app/screens/main_nav_screen.dart';
import 'package:task_manager_app/screens/recover_otp_screen.dart';
import 'package:task_manager_app/screens/sign_up_screen.dart';
import 'package:task_manager_app/screens/splash_screen.dart';
import 'package:task_manager_app/service/api_caller.dart';
import 'package:task_manager_app/utils/urls.dart';
import 'package:task_manager_app/widgets/screen_bg.dart';

import '../models/api_response.dart';
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  onTapSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ScreenBG(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 150,),
                Text('Your Email Address',style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 25,),
                Text('A 6 digit verification pin will send to your email adress',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey)),
                const SizedBox(height: 25,),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email"
                  ),
                ),

                const SizedBox(height: 20,),

                FilledButton(onPressed: () async {
                  final email =   emailController.text.trim();

                  if(email.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter your email."),
                      ),
                    );
                    return;
                  }
                  final ApiResponse response = await ApiCaller.getRequest(
                    url: TMUrls.recoverVerifyEmail(email),
                  );
                  if(response.isSuccess){

                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context)=>RecoverOtpScreen(email: email,),
                    ),
                    );


                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(
                          response.errorMessage ??' "Something went wrong'))
                    );
                  }
                }, child: Icon(Icons.arrow_right_alt_outlined)),


                SizedBox(height: 30,),
                Center(
                  child: RichText(text:TextSpan(
                    text: "Login with...",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                    children: [
                        TextSpan(
                            text: 'password',
                            style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap  = onTapSignIn

                        ),
                    ],
                  ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
