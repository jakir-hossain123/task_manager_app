import 'package:flutter/material.dart';
import 'package:task_manager_app/models/api_response.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/models/task_status_count_model.dart';
import 'package:task_manager_app/service/api_caller.dart';

import '../utils/urls.dart';
import '../widgets/task_card.dart';
import '../widgets/task_card_count.dart';
import 'add_task_screen.dart';
class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState(){
    super.initState();
    getAllTaskCount();
    getAllTask('New');
  }

  List<TaskStatusCountModel> taskCountByStatus =[];
  List<TaskModel> taskList =[];

  Future<void> getAllTask(String status)async {
    final ApiResponse  response= await ApiCaller.getRequest(url:
    TMUrls.taskListByStatus(status));

    List<TaskModel> tList =[];


    if(response.isSuccess){
      for(Map<String,dynamic> jsonData in response.responseData ['data']){
        tList.add(TaskModel.fromJson(jsonData));
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text(response.responseData['data'])));
    }
    setState(() {
      taskList = tList ;
    });
  }



  Future<void> getAllTaskCount ()async {
    final ApiResponse  response= await ApiCaller.getRequest(url: TMUrls.taskStatusCount);

    List<TaskStatusCountModel> taskCount =[];


    if(response.isSuccess){
      for(Map<String,dynamic> jsonData in response.responseData ['data']){
        taskCount.add(TaskStatusCountModel.fromJson(jsonData));
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.responseData['data'])));
    }
    setState(() {
      taskCountByStatus = taskCount;
    });
  }



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
              itemCount: taskCountByStatus.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100,
                    child: TaskCardCount(
                      title: taskCountByStatus[index].sId.toString(),
                      count: taskCountByStatus[index].sum!.toInt(),));
              }, separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 5,);
            },
            ),
          ),

          Expanded(
            child: ListView.builder(

                itemCount: taskList.length,
                itemBuilder: (context , index){
                  return TaskCard(taskModel: taskList[index],
                    cardColor: Colors.blue, refreshParent: () {

                    getAllTaskCount();
                    getAllTask('New');
                    },);
                }


            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
          },
        child: Icon(Icons.add),
      ),

    );
  }
}



