import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:smart_class/controller/teacher_controller.dart';
import 'package:smart_class/models/class_model.dart';
import 'package:smart_class/models/course_model.dart';
import 'package:smart_class/models/location_model.dart';
import 'package:smart_class/models/teacher_model.dart';

import '../models/attendance_model.dart';

class TeacherApi {
  final teacherController = Get.find<TeacherController>();
  static const baseUrl = "http://192.168.27.75:3000/teacher/";

  static Future<TeacherModel?> registerTeacher(TeacherModel teacher) async {
    var url = Uri.parse(baseUrl + "register");
    TeacherModel? myTeacher;
    try {
      final body = teacher.toJson();
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (res.statusCode == 201) {
        Get.snackbar("Success!", "Registration Successful!");
        final data = jsonDecode(res.body);
        myTeacher = TeacherModel.fromJson(data);
        return myTeacher;
      } else if (res.statusCode == 502) {
        Get.snackbar("Old User!", "Email already exists");
      }
    } catch (err) {
      Get.snackbar("Error!", err.toString());
    }
    return null;
  }

  static Future<TeacherModel?> loginTeacher(
      String email, String password) async {
    var url = Uri.parse(baseUrl + "login");
    try {
      final body = {"email": email, "password": password};
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));

      if (res.statusCode == 201) {
        Get.snackbar("Success!", "Logged in successfully");
        final data = jsonDecode(res.body);
        TeacherModel newTeacher = TeacherModel.fromJson(data);
        return newTeacher;
      } else if (res.statusCode == 502) {
        Get.snackbar("Error!", "Email doesn't exist");
      } else if (res.statusCode == 501) {
        Get.snackbar("Error!", "Incorrect Password");
      }
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
    return null;
  }

  static Future<Map<String, dynamic>?> createCourse(CourseModel course) async {
    var url = Uri.parse(baseUrl + "createcourse");
    try {
      final body = course.toJson();
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (res.statusCode == 201) {
        final data = jsonDecode(res.body);
        CourseModel? myCourse = CourseModel.fromJson(data['New Course']);
        final myTeacher = List<String>.from(data['Teacher']);
        print(myTeacher);
        print(myCourse);
        Map<String, dynamic> result = {
          "course" : myCourse,
          "teacher" : myTeacher,
        };
        Get.snackbar("Success!", "Course Created Successfully!");
        return result;
      }
      else if(res.statusCode == 409)
        {
          Get.snackbar("Course ID already exists!", "Enter another ID");
        }
    } catch (err) {
      Get.snackbar("Error!", err.toString());
    }
    return null;
  }

  static Future<Map<String, dynamic>?> setLocation(LocationModel location) async {
    var url = Uri.parse(baseUrl + "setlocation");
    try {
      final body = location.toJson();
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (res.statusCode == 201) {
        Get.snackbar("Success!", "Location added successfully!");
        final data = jsonDecode(res.body);
        LocationModel myLocation = LocationModel.fromJson(data['location']);
        final myTeacher = List<String>.from(data['Teacher']);
        return {
          "location" : myLocation,
          "teacher" : myTeacher,
        };
      }
    } catch (err) {
      Get.snackbar("Error!", err.toString());
    }
    return null;
  }

  static Future<List<CourseModel>?> getCourses(List<String> courses) async {
    var url = Uri.parse(baseUrl + "getcourse");
    try {
      final body = {"courses": courses};
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (res.statusCode == 201) {
        final data = jsonDecode(res.body);
        List<CourseModel>? allCourses = List<CourseModel>.from(
            data['courses'].map((course) => CourseModel.fromJson(course)));
        return allCourses;
      } else if (res.statusCode == 404) {
        Get.snackbar("Error!", "No Courses Found");
      }
    } catch (err) {
      Get.snackbar("Error!", err.toString());
    }
    return null;
  }

  static Future<List<LocationModel>?> getLocations(
      List<String> locations) async {
    var url = Uri.parse(baseUrl + "getlocation");
    try {
      final body = {"locations": locations};
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));

      if (res.statusCode == 201) {
        final data = jsonDecode(res.body);
        List<LocationModel>? myLocations = List<LocationModel>.from(
            data['locations']
                .map((location) => LocationModel.fromJson(location)));
        return myLocations;
      } else if (res.statusCode == 404) {
        Get.snackbar("Error!!", "No locations found");
      }
    } catch (err) {
      Get.snackbar("Error!", err.toString());
    }
    return null;
  }

  static Future<Map<String, dynamic>?> createClass(ClassModel myClass) async
  {
    var url = Uri.parse(baseUrl + "createclass");
    try{
      final body = myClass.toJson();
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      if(res.statusCode == 201)
        {
          final data = jsonDecode(res.body);
          ClassModel newClass = ClassModel.fromJson(data['class']);
          List<String> classList = List<String>.from(data['class_list']);
          Get.snackbar("Success!", "Class created successfully");
          return {
            "class" : newClass,
            "class_list" : classList,
          };
        }

    }catch(err){
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

  static Future<List<Map<String, dynamic>>?> getAttendingStudents(List<String> attendances) async
  {
    var url = Uri.parse(baseUrl + "getclassstudents");
    print(attendances);
    try{
      final body = {
        "attendance" : attendances,
      };
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      if(res.statusCode == 200)
        {
          final data = jsonDecode(res.body);
          if(data.containsKey('Students') && data['Students'] is List)
            {
              List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(data['Students'].map((student) => {
                "name" : student['name'],
                "roll" : student['roll']
              }));
              return result;
            }
          else {
            Get.snackbar("Error!", "Unexpected response fromat");
            return [];
          }

        }
    }catch(err)
    {
      Get.snackbar("Error!", err.toString());
    }
    return null;
  }

}
