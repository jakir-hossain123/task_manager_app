import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Text title',style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 18,
        ),),
        subtitle: Column(crossAxisAlignment: .start,
          children: [
            Text("des"),
            SizedBox(height: 5,),
            Text('Date: 20/20-/29'),
            Row(
              children: [
                Chip(

                  label: Text('New Status',style: TextStyle(color: Colors.white),),
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
