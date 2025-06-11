import 'package:get/get.dart';
import 'package:smart_class/models/course_model.dart';
import 'package:smart_class/models/location_model.dart';
import 'package:smart_class/models/teacher_model.dart';
import 'package:smart_class/services/teacher_api.dart';

import '../../models/class_model.dart';

class TeacherApiController extends GetxController{


  registerTeacher(TeacherModel teacher)
  {
    return TeacherApi.registerTeacher(teacher);
  }

  loginTeacher(String email, String password)
  {
    return TeacherApi.loginTeacher(email, password);
  }

  getCourses(List<String> courses)
  {
    return TeacherApi.getCourses(courses);
  }

  createCourse(CourseModel course)
  {
    return TeacherApi.createCourse(course);
  }

  setLocation(LocationModel location)
  {
    return TeacherApi.setLocation(location);
  }

  getLocations(List<String> locations)
  {
    return TeacherApi.getLocations(locations);
  }
  createClass(ClassModel myClass)
  {
    return TeacherApi.createClass(myClass);
  }
  getClasses(List<String> myClasses)
  {
    return TeacherApi.getClasses(myClasses);
  }

  getClassStudents(List<String> attendances)
  {
    return TeacherApi.getAttendingStudents(attendances);
  }
}