import 'package:get/get.dart';
import 'package:smart_class/controller/api/student_api_controller.dart';
import 'package:smart_class/models/class_model.dart';
import 'package:smart_class/models/course_model.dart';

class StudentCourseController extends GetxController{

  var course = CourseModel(name: "", courseId: "", teacher: "").obs;

  var classes = <ClassModel>[].obs;

  final StudentApiController apiController = Get.put(StudentApiController());

  Future<void> loadClasses()async
  {
    if(course.value.classes != null && course.value.classes!.isNotEmpty) {
      final result = await apiController.getClasses(course.value.classes!);
      classes.assignAll(result);
    }
  }

  void setCourse(CourseModel myCourse)
  {
    course.value = myCourse;
  }

}