import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/models/user_model.dart';
import 'package:task_manager_app/screens/login_screen.dart';
import 'package:task_manager_app/screens/main_nav_screen.dart';
import 'package:task_manager_app/screens/recover_reset_password.dart';
import 'package:task_manager_app/screens/sign_up_screen.dart';
import 'package:task_manager_app/screens/splash_screen.dart';
import 'package:task_manager_app/service/api_caller.dart';
import 'package:task_manager_app/utils/urls.dart';
import 'package:task_manager_app/widgets/screen_bg.dart';

import '../models/api_response.dart';
class RecoverOtpScreen extends StatefulWidget {
  final String email;
  const RecoverOtpScreen({super.key, required this.email});

  @override
  State<RecoverOtpScreen> createState() => _RecoverOtpScreenState();
}

class _RecoverOtpScreenState extends State<RecoverOtpScreen> {
  final TextEditingController otpController = TextEditingController();
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
                Text('PIN Verification ',style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 25,),
                Text('A 6 digit verification pin has been to your email adress',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey)),
                const SizedBox(height: 25,),
                TextFormField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    hintText: "OTP",
                  ),
                ),

                const SizedBox(height: 20,),

                FilledButton(onPressed: () async {
                  final otp = otpController.text.trim();

                  if (otp.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter your OTP."),
                      ),
                    );
                    return;
                  }

                  final ApiResponse response = await ApiCaller.getRequest(
                    url: TMUrls.recoverVerifyOtp(
                      widget.email,
                      otp,
                    ),
                  );

                  if (response.isSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecoverResetPassword(
                          email: widget.email,
                          otp: otp,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          response.errorMessage ?? "Invalid OTP",
                        ),
                      ),
                    );
                  }
                }, child: Text('Verify')),



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
