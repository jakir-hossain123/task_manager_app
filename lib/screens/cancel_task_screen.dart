import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_card_count.dart';
class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
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
                    child: TaskCardCount(title: 'can', count: 25,));
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
