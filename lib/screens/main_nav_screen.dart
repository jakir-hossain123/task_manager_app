import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/cancel_task_screen.dart';
import 'package:task_manager_app/screens/completed_task_screen.dart';
import 'package:task_manager_app/screens/new_task_screen.dart';
import 'package:task_manager_app/screens/progress_task_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int selectedIndex = 0;
  List screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2024/02/24/22/37/ai-generated-8594846_640.png"),
              radius: 25,
            ),
            SizedBox(width: 10,),
            Column(crossAxisAlignment: .start,
              children: [
                Text("MD. Jakir Hossain",style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),),
                Text("jakir.dev1@gmail.com",style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white
                ),),

              ],
            )
          ],
        ),
      ),

      body: screens[
        selectedIndex
      ],

      bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index){
            selectedIndex = index;
            setState(() {
            });
          },
          destinations: [
        NavigationDestination(icon: Icon(Icons.task), label: 'New'),
        NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
        NavigationDestination(icon: Icon(Icons.task_alt_outlined), label: 'Completed'),
        NavigationDestination(icon: Icon(Icons.cancel_outlined), label: 'Cancel'),

      ]
      ),
    );
  }
}
