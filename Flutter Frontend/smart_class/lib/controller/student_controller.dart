import 'package:get/get.dart';
import 'package:smart_class/controller/api/student_api_controller.dart';
import 'package:smart_class/models/course_model.dart';
import 'package:smart_class/models/student_model.dart';

class StudentController extends GetxController{
  var student = StudentModel(name: "", roll: 0, email: "", password: "", contact: 0).obs;

  var courses = <CourseModel>[].obs;
  final apiController = Get.put(StudentApiController());

  Future<void> setCourses() async
  {
    if(student.value.courses != null && student.value.courses!.isNotEmpty)
      {
        final result = await apiController.getCourses(student.value.courses!);
        courses.assignAll(result);
      }
    return;
  }

  void setStudent(StudentModel myStudent)
  {
    student.value = myStudent;
  }
}