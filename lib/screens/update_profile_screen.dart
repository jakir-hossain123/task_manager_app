import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/models/api_response.dart';
import 'package:task_manager_app/models/user_model.dart';
import 'package:task_manager_app/screens/login_screen.dart';
import 'package:task_manager_app/screens/main_nav_screen.dart';
import 'package:task_manager_app/service/api_caller.dart';
import 'package:task_manager_app/utils/urls.dart';
import 'package:task_manager_app/widgets/screen_bg.dart';
import 'package:task_manager_app/widgets/tm_app_bar.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> upDateProfile() async {

    Map<String,dynamic> requestBody = {
      "email": emailController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "mobile": mobileController.text,
    };

    if(passwordController.text.isNotEmpty){
      requestBody['password'] = passwordController.text;
    }

    final ApiResponse response =  await ApiCaller.postRequest(url:
    TMUrls.profileUpDate,
        body: requestBody
    );
    if(response.isSuccess){
      UserModel model = UserModel(
        sId: AuthController.userData?.sId,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobile: mobileController.text,
      );

      AuthController.upDateUserData(model);
      Navigator.pushReplacement(context, MaterialPageRoute(builder:
          (context)=> MainNavScreen()));
    }
  }

@override
void initState(){
    super.initState();
    UserModel user = AuthController.userData!;
    emailController.text = user.email!;
    firstNameController.text = user.firstName!;
    lastNameController.text =user.lastName!;
    mobileController.text = user.mobile!;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),

      body: ScreenBG(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 100,),
                  Text('Update Profile',style: Theme.of(context).textTheme.titleLarge),
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
                    upDateProfile();

                  }, child: Icon(Icons.arrow_right_alt_outlined)),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
