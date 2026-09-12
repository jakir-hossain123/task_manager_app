import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel  taskModel;
  final Color  cardColor;
  final VoidCallback refreshParent;
  const TaskCard({
    super.key, required this.taskModel, required this.cardColor, required this.refreshParent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(taskModel.title.toString(),style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 18,
        ),),
        subtitle: Column(crossAxisAlignment: .start,
          children: [
            Text(taskModel.description.toString()),
            SizedBox(height: 5,),
            Text('Date: ${taskModel.createdDate.toString()}'),
            Row(
              children: [
                Chip(

                  label: Text(taskModel.status.toString(),style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.blue,
                ),
                Spacer(),

                IconButton(onPressed: () {

                }, icon: Icon(Icons.edit,color: Colors.red,)),IconButton(onPressed: () {

                }, icon: Icon(Icons.delete,color: Colors.orange,)),

              ],
            )
          ],
        ),
      ),
    );
  }
}
