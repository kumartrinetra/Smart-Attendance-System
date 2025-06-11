import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_class/models/attendance_model.dart';
import 'package:smart_class/models/course_model.dart';
import 'package:smart_class/models/location_model.dart';
import '../models/class_model.dart';
import '../models/student_model.dart';

class StudentApi {
  static const baseUrl = "http://192.168.27.75:3000/student/";

  static Future<StudentModel?> registerStudent(StudentModel student) async {
    var url = Uri.parse(baseUrl + "register");
    StudentModel? myStudent;
    try {
      final body = student.toJson();
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (res.statusCode == 201) {
        Get.snackbar("Success!", "Registration Successful!");
        final data = jsonDecode(res.body);
        myStudent = StudentModel.fromJson(data);
        return myStudent;
      } else if (res.statusCode == 502) {
        Get.snackbar("Old User!", "Email already exists");
      }
    } catch (err) {
      print(err);
      Get.snackbar("Error", err.toString());
    }
    return null;
  }

  static Future<StudentModel?> loginStudent(
      String email, String password) async {
    var url = Uri.parse(baseUrl + "login");
    try {
      final body = {"email": email, "password": password};
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (res.statusCode == 201) {
        Get.snackbar("Success!", "Logged in successfully");
        final data = res.body;
        StudentModel newStudent = StudentModel.fromJson(jsonDecode(data));
        return newStudent;
      } else if (res.statusCode == 502) {
        Get.snackbar("Error!", "Email doesn't exist");
      } else if (res.statusCode == 501) {
        Get.snackbar("Error!", "Incorrect Password");
      }
    } catch (err) {
      Get.snackbar("Error!", err.toString());
    }
    return null;
  }

  static Future<List<CourseModel>?> getCourses(List<String> courses) async {
    var url = Uri.parse(baseUrl + "getcourses");
    try {
      final body = {"courses": courses};
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      if (res.statusCode == 201) {
        final data = jsonDecode(res.body);
        List<CourseModel>? myCourses = List<CourseModel>.from(
            data['Courses'].map((course) => CourseModel.fromJson(course)));
        return myCourses;
      } else if (res.statusCode == 404) {
        Get.snackbar("Error", "No Courses Found");
      }
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
    return null;
  }

  static Future<Map<String, dynamic>?> registerCourse(
      String courseId, String studentId) async {
    var url = Uri.parse(baseUrl + "registercourse");
    try {
      final body = {
        "studentId" : studentId,
        "courseId" : courseId
      };
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      if(res.statusCode == 201)
        {
          final data = jsonDecode(res.body);
          final myCourse = CourseModel.fromJson(data['Course']);
          final course_list = List<String>.from(data['course_list']);
          Get.snackbar("Success!", "Registered Successfully");
          return {
            "myCourse" : myCourse,
            "course_list" : course_list
          };
        }
      else if(res.statusCode == 404)
        {
          Get.snackbar("Course does not exist", "Enter another course id");
        }
      else if(res.statusCode == 409)
        {
          Get.snackbar("Already Registered!", "Enter another course id");
        }
    } catch (err) {
      Get.snackbar("Error!", err.toString());
    }
    return null;
  }

  static Future<List<ClassModel>?> getClasses(List<String> classes) async{
    var url = Uri.parse(baseUrl + "getclasses");
    try{
      final body = {
        "classes" : classes
      };
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      if(res.statusCode == 201)
      {
        final data = jsonDecode(res.body);
        List<ClassModel> myClasses = List<ClassModel>.from(data['classes'].map((currClass) => ClassModel.fromJson(currClass)));
        return myClasses;
      }
    }catch(err){
      Get.snackbar("Error!", err.toString());
    }
    return null;
  }

  static Future<Map<String, dynamic> ?> markAttendance(AttendanceModel attendance) async
  {
    var url = Uri.parse(baseUrl + "markattendance");
    try{
      final body = attendance.toJson();
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      if(res.statusCode == 201)
        {
          final data = jsonDecode(res.body);
          final myAttendance = AttendanceModel.fromJson(data['attendance']);
          final attendance_list = List<String>.from(data['attendance_list']);
          Get.snackbar("Attendance Marked!", "You are present in this class.");
          return {
            "attendance" : myAttendance,
            "list" : attendance_list,
          };
        }

    }catch(err){
      Get.snackbar("Error!", err.toString());
    }



    return null;
  }

  static Future<List<AttendanceModel>?> getAttendances(List<String> attendances) async{
    var url = Uri.parse(baseUrl + "getattendances");
    try{
      final body = {
        "attendances" : attendances,
      };
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      if(res.statusCode == 201)
        {
          final data = jsonDecode(res.body);
          List<AttendanceModel> myList = List<AttendanceModel>.from(data['list'].map((attendance) => AttendanceModel.fromJson(attendance)));
          return myList;
        }
      else if(res.statusCode == 404)
        {
          Get.snackbar("Error!", "No attendance marked");
        }
    }catch(err){Get.snackbar("Error!", err.toString());}

    return null;
  }
  
  static Future<LocationModel?> getLocation(String location) async
  {
    var url = Uri.parse(baseUrl + "getlocation");
    try{
      
      final body = {
        "location" : location
      };
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      if(res.statusCode == 201)
        {
          final data = jsonDecode(res.body);
          final myLocation = LocationModel.fromJson(data['location']);
          return myLocation;
        }
      else if(res.statusCode == 404)
        {
          Get.snackbar("Invalid location", "No location exists");
        }
    }catch(err){
      Get.snackbar("Error!", err.toString());
    }
    return null;
  }
}
