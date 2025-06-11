import 'package:get/get.dart';
import 'package:smart_class/controller/api/teacher_api_controller.dart';
import 'package:smart_class/models/course_model.dart';
import 'package:smart_class/models/location_model.dart';
import 'package:smart_class/models/teacher_model.dart';

class TeacherController extends GetxController{
  var teacher = TeacherModel(name: "", email: "", password: "", contact: 0, id: "").obs;


  var courses = <CourseModel>[].obs;
  var locations = <LocationModel>[].obs;
  final apiController = Get.put(TeacherApiController());
  Future<void> loadCourses () async
  {
    final result = await apiController.getCourses(teacher.value.courses!);
    courses.assignAll(result);
  }

  Future<void> loadLocations()async {
    final result = await apiController.getLocations(teacher.value.locations!);
    locations.assignAll(result);
  }
  void setTeacher(TeacherModel newTeacher)
  {
    teacher.value = newTeacher;
  }
}