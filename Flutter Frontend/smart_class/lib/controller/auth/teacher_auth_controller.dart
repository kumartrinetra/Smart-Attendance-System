import 'package:get/get.dart';
import 'package:smart_class/controller/api/teacher_api_controller.dart';
import 'package:smart_class/models/teacher_model.dart';

class TeacherAuthController extends GetxController{
  TeacherApiController apiController = Get.put(TeacherApiController());
  registerTeacher(TeacherModel teacher)
  {
    return apiController.registerTeacher(teacher);
  }

  loginTeacher(String email, String password)
  {
    return apiController.loginTeacher(email, password);
  }
}