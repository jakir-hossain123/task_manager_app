import 'package:flutter/material.dart';
import 'package:task_manager_app/models/api_response.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/service/api_caller.dart';
import 'package:task_manager_app/utils/urls.dart';

class TaskCard extends StatefulWidget {
  final TaskModel  taskModel;
  final Color  cardColor;
  final VoidCallback refreshParent;
  const TaskCard({
    super.key, required this.taskModel, required this.cardColor, required this.refreshParent,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  Future<void> deleteTask() async {
    final ApiResponse response = await ApiCaller.getRequest(url: TMUrls.deleteTask(widget.taskModel.sId.toString()));
  setState(() {

  });

  if(response.isSuccess){
    widget.refreshParent();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task deleted successfully!')),
    );
  }else{
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went Wrong!'))
    );
  }
  }


  Future<void> changeStatus(String status) async {
    final ApiResponse response = await ApiCaller
        .getRequest(url: TMUrls.updateTaskStatusUrl(
        widget
            .taskModel.sId.toString(), status));
  setState(() {

  });

  if(response.isSuccess){
    widget.refreshParent();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task status updated successfully!')),
    );
  }else{
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went Wrong!'))
    );
  }
  }


  void showChangeStatusDialog(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Change Status"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: ListTile(
              title: Text("New"),
              onTap: (){
                changeStatus('New');
                Navigator.pop(context);
              },
              trailing: widget.taskModel.status == 'New' ? Icon(Icons.check, color: Colors.blue) : null,

            ),
          ),
          Card(
            child: ListTile(
              title: Text("Progress"),
              onTap: (){
                changeStatus('Progress');
                Navigator.pop(context);
              },
              trailing: widget.taskModel.status == 'Progress' ? Icon(Icons.check, color: Colors.purple) : null,

            ),
          ),
          Card(
            child: ListTile(
              title: Text("Completed"),
              onTap: (){
                changeStatus('Completed');
                Navigator.pop(context);
              },
              trailing: widget.taskModel.status == 'Completed' ? Icon(Icons.check, color: Colors.green) : null,

            ),
          ),
          Card(
            child: ListTile(
              title: Text("Cancel"),
              onTap: (){
                changeStatus('Cancel');
                Navigator.pop(context);
              },
              trailing: widget.taskModel.status == 'Cancel' ? Icon(Icons.check, color: Colors.red) : null,
            ),
          ),
        ],
      )
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.taskModel.title.toString(),style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 18,
        ),),
        subtitle: Column(crossAxisAlignment: .start,
          children: [
            Text(widget.taskModel.description.toString()),
            SizedBox(height: 5,),
            Text('Date: ${widget.taskModel.createdDate.toString()}'),
            Row(
              children: [
                Chip(

                  label: Text(widget.taskModel.status.toString(),style: TextStyle(color: Colors.white),),
                  backgroundColor: widget.cardColor,
                ),
                Spacer(),

                IconButton(
                    onPressed: () {
                      showChangeStatusDialog();
                    },
                    icon: Icon(Icons.edit,color: Colors.orange,)
                ),
             IconButton(
                  onPressed: () {
                    deleteTask();
                  },
                  icon: Icon(Icons.delete,color: Colors.red,)
             ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
