import 'package:get/get.dart';
import 'package:smart_class/models/attendance_model.dart';
import 'package:smart_class/models/student_model.dart';
import 'package:smart_class/services/student_api.dart';

class StudentApiController extends GetxController {
  registerStudent(StudentModel student) {
    return StudentApi.registerStudent(student);
  }

  loginStudent(String email, String password)
  {
    return StudentApi.loginStudent(email, password);
  }

  registerCourse(String courseId, String studentId)
  {
    return StudentApi.registerCourse(courseId, studentId);
  }

  getCourses(List<String> courses)
  {
    return StudentApi.getCourses(courses);
  }

  getClasses(List<String> classes)
  {
    return StudentApi.getClasses(classes);
  }

  markAttendance(AttendanceModel attendance)
  {
    return StudentApi.markAttendance(attendance);
  }

  getAttendances(List<String> attendances)
  {
    return StudentApi.getAttendances(attendances);
  }

  getLocation(String location)
  {
    return StudentApi.getLocation(location);
  }

}
