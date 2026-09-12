class TMUrls{
  static String baseUrl = 'https://task-manager-api.ostad.live/api/v1';
  static String signUpUrl = '$baseUrl/Registration';
  static String loginUrl = '$baseUrl/Login';
  static String taskStatusCount = '$baseUrl/TaskStatusCount';
  static String taskListByStatus (String status)=> '$baseUrl/ListTaskByStatus/$status';
  static String deleteTask (String ID)=> '$baseUrl/deleteTask/$ID';
  static String updateTaskStatusUrl (String ID, String status)=> '$baseUrl/updateTaskStatus/$ID/$status';
  static String addNewTask = '$baseUrl/createTask';
  static String profileUpDate = '$baseUrl/ProfileUpdate';
}