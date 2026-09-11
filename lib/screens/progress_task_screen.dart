import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_card_count.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200 ,
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return SizedBox(
                    width: 100,
                    child: TaskCardCount(title: 'prog', count: 25,));
              }, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 5,);
            },
            ),
          ),

          Expanded(
            child: ListView.builder(

                itemCount: 20,
                itemBuilder: (context , index){
                  return TaskCard();
                }


            ),
          )
        ],
      ),
    );
  }
}
