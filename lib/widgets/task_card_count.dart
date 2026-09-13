import 'package:flutter/material.dart';
class TaskCardCount extends StatelessWidget {
  final String title;
  final int count;
  const TaskCardCount({
    super.key, required this.title, required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0,vertical: 8),
        child: Column(
          children: [
            Text(count.toString(), style: Theme.of(context).textTheme.titleLarge,),
            Text(title)
          ],
        ),
      ),
    );
  }
}