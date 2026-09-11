import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/login_screen.dart';
import 'package:task_manager_app/widgets/screen_bg.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  onTapSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
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
                Text('Join with us',style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 25,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Email"
                  ),
                ),
                const SizedBox(height: 25,),TextFormField(
                  decoration: InputDecoration(
                      hintText: "First Name"
                  ),
                ),
                const SizedBox(height: 25,),TextFormField(
                  decoration: InputDecoration(
                      hintText: "Last Name"
                  ),
                ),
                const SizedBox(height: 25,),TextFormField(
                  decoration: InputDecoration(
                      hintText: "Mobile"
                  ),
                ),
                const SizedBox(height: 25,),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password"
                  ),
                ),

                const SizedBox(height: 20,),

                FilledButton(onPressed: (){}, child: Icon(Icons.arrow_right_alt_outlined)),

                SizedBox(height: 70,),
                Center(
                  child: Column(
                    children: [
                      RichText(text: TextSpan(
                          text: "Already have an account ?",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text: ' Sign In',
                                style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()..onTap = onTapSignIn
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
