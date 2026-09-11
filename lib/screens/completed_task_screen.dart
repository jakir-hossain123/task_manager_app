import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_card_count.dart';
class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
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
                    child: TaskCardCount(title: 'com', count: 25,));
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
