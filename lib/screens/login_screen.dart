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

import '../models/api_response.dart';
import 'forget_password_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  onTapSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
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
                Text('Get started with',style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 25,),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email"
                  ),
                ),
                const SizedBox(height: 25,),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password"
                  ),
                ),

                const SizedBox(height: 20,),

                FilledButton(onPressed: () async {
                  final ApiResponse response =  await ApiCaller.postRequest(url:
                  TMUrls.loginUrl,
                      body: {
                        "email": emailController.text,
                        "password": passwordController.text
                      }
                  );
                  if(response.isSuccess && response.responseData['status'] == 'success'){
                    UserModel model = UserModel.fromJson(response.responseData['data']);
                    String token = response.responseData['token'];

                    AuthController.saveUserData(model, token);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:
                        (context)=> MainNavScreen()));
                  }
                }, child: Icon(Icons.arrow_right_alt_outlined)),

                SizedBox(height: 30,),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()
                            ),
                            );
                          }, child: Text("Forgot password..?",
                        style: TextStyle(color: Colors.grey
                        ),
                      ),
                      ),
                      RichText(text: TextSpan(
                        text: "Don't have an account ?",
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                       children: [
                          TextSpan(
                            text: ' Sign up',
                            style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap  = onTapSignUp

                          )
                        ]

                        )
                      )
                    ],
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
