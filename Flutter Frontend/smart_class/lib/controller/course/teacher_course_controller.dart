import 'package:get/get.dart';
import 'package:smart_class/controller/api/teacher_api_controller.dart';
import 'package:smart_class/models/class_model.dart';
import 'package:smart_class/models/course_model.dart';

class TeacherCourseController extends GetxController{
  var course = CourseModel(name: "", courseId: "", teacher: "").obs;

  var classes = <ClassModel>[].obs;
  TeacherApiController apiController = Get.put(TeacherApiController());

  Future<void> loadClasses() async
  {
    final result = await apiController.getClasses(course.value.classes!);
    classes.assignAll(result);
  }


  void setCourse(CourseModel myCourse)
  {
    course.value = myCourse;
  }
}