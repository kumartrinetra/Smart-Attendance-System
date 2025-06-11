import 'package:smart_class/models/course_model.dart';

class StudentModel {
  String name;
  String password;
  int roll;
  String? id;
  String email;
  int contact;
  String? profilePic;
  bool isTeacher = false;
  List<String>? courses;

  StudentModel({
    required this.name,
    required this.roll,
    this.id,
    required this.email,
    required this.password,
    required this.contact,
    this.isTeacher = false,
    this.profilePic,
    this.courses,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "roll": roll,
      "email": email,
      "_id" : id,
      "password" : password,
      "contact": contact,
      "profilePic": profilePic,
      "isTeacher": isTeacher,
      "courses": courses,
    };
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      roll: json['roll'],
      email: json['email'],
      contact: json['contact'],
      password: json['password'],
      id: json['_id'],
      isTeacher: json['isTeacher'],
      profilePic: json['profilePic'],
      courses: json['courses'] != null
          ? List<String>.from(json['courses'])
          : null,
    );
  }
}
