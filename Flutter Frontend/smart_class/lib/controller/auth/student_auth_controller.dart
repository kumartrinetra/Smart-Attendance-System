import 'package:get/get.dart';
import 'package:smart_class/controller/api/student_api_controller.dart';
import 'package:smart_class/models/student_model.dart';

class StudentAuthController extends GetxController{
  StudentApiController apiController = StudentApiController();
  registerStudent(StudentModel student)
  {
    return apiController.registerStudent(student);
  }

  loginStudent(String email, String password)
  {
    return apiController.loginStudent(email, password);
  }
}