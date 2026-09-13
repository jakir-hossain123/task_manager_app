import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/login_screen.dart';
import 'package:task_manager_app/service/api_caller.dart';
import 'package:task_manager_app/utils/urls.dart';
import 'package:task_manager_app/widgets/screen_bg.dart';
import '../models/api_response.dart';

class RecoverResetPassword extends StatefulWidget {
  final String email;
  final String otp;
  const RecoverResetPassword({super.key, required this.email, required this.otp});

  @override
  State<RecoverResetPassword> createState() => _RecoverResetPasswordState();
}

class _RecoverResetPasswordState extends State<RecoverResetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  void onTapSignIn(){
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
                Text('Set Password',style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 25,),
                Text('Minimum length password 8 character with \n Latter and number combination',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey)),
                const SizedBox(height: 25,),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: confirmPassController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Confirm Password",
                  ),
                ),

                const SizedBox(height: 20,),

                FilledButton(
                  onPressed: () async {
                    final password = passwordController.text.trim();
                    final confirmPassword = confirmPassController.text.trim();

                    if (password.isEmpty || confirmPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter your password."),
                        ),
                      );
                      return;
                    }

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Passwords do not match."),
                        ),
                      );
                      return;
                    }

                    final ApiResponse response = await ApiCaller.postRequest(
                      url: TMUrls.recoverResetPassword,
                      body: {
                        "email": widget.email,
                        "OTP": widget.otp,
                        "password": password,
                      },
                    );

                    if (response.isSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password reset successful."),
                        ),
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                            (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            response.errorMessage ?? "Password reset failed.",
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Confirm'),
                ),



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
