class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static  String registerUrl = '$_baseUrl/Registration';
  static  String loginUrl = '$_baseUrl/Login';
  static  String profileUpdate = '$_baseUrl/ProfileUpdate';
  static  String createTaskUrl = '$_baseUrl/createTask';
  static  String taskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static  String newTaskListUrl = '$_baseUrl/listTaskByStatus/New';
  static  String cancelledListUrl = '$_baseUrl/listTaskByStatus/Cancelled';
  static  String completedListUrl = '$_baseUrl/listTaskByStatus/Completed';
  static  String progressListUrl = '$_baseUrl/listTaskByStatus/Progress';
  static  String resetPasswordUrl = '$_baseUrl/RecoverResetPassword';
  static  String recoverVerifyEmail(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static  String verifyOtpUrl(String email, String otp) => '$_baseUrl/RecoverVerifyOtp/$email/$otp';
  static  String deleteTaskUrl(String taskId) => '$_baseUrl/deleteTask/$taskId';
  static  String updateTaskStatusUrl(String taskID, String status) => '$_baseUrl/updateTaskStatus/$taskID/$status';
}