import 'package:smart_class/models/class_model.dart';
import 'package:smart_class/models/student_model.dart';

class CourseModel {
  String name;
  String courseId;
  String? id;
  List<String>? classes;
  List<StudentModel>? students;
  String? duration;
  String teacher;

  CourseModel(
      {required this.name,
      required this.courseId,
      this.classes,
        this.id,
        required this.teacher,
      this.students,
      this.duration});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "courseId": courseId,
      "duration": duration,
      "_id" : id,
      "teacher" : teacher,
      "classes": classes
    };
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      name: json['name'],
      courseId: json['courseId'],
      duration: json['duration'],
      teacher: json['teacher'],
      id: json['_id'],
      classes: json['classes'] != null
          ? List<String>.from(
              json['classes'])
          : null,
    );
  }
}
