import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/models/api_response.dart';
import 'package:task_manager_app/screens/login_screen.dart';
import 'package:task_manager_app/service/api_caller.dart';
import 'package:task_manager_app/utils/urls.dart';
import 'package:task_manager_app/widgets/screen_bg.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Future<void> onTapSignUp() async {
    final ApiResponse response =  await ApiCaller.postRequest(url:
    TMUrls.signUpUrl,
    body: {
      "email": emailController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "mobile": mobileController.text,
      "password": passwordController.text
    }
    );
    if(response.isSuccess){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:
          (context)=> LoginScreen()));
    }
  }
  void onTapSignIn (){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ScreenBG(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 150,),
                  Text('Join with us',style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 25,),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email"
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter Email";
                      }else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25,),TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                        hintText: "First Name"
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter First Name";
                      }else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25,),TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                        hintText: "Last Name"
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter Last Name";
                      }else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25,),TextFormField(
                    controller: mobileController,
                    decoration: InputDecoration(
                        hintText: "Mobile"
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter Mobile Number";
                      }else if(value.length<11){
                        return "Mobile Number must be at least 11 characters";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password"
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter Password";
                      }else if(value.length<6){
                        return"Password must be at least 6 characters";
                      }
                      else{
                        return null;
                      }
                    },
                  ),

                  const SizedBox(height: 20,),

                  FilledButton(onPressed: (){
                    onTapSignUp();

                  }, child: Icon(Icons.arrow_right_alt_outlined)),

                  SizedBox(height: 30,),
                  Center(
                    child: Column(
                      children: [
                        RichText(text: TextSpan(
                            text: "Already have an account ?",
                            style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                  text: ' Sign In',
                                  style:
                                  TextStyle(color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                recognizer:
                                TapGestureRecognizer()..onTap = onTapSignIn
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
      ),
    );
  }
}
