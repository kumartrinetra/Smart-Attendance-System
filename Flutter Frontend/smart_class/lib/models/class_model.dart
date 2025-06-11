import 'package:smart_class/models/location_model.dart';
import 'package:smart_class/models/student_model.dart';

class ClassModel {
  String name;
  String? date;
  String? duration;
  List<String>? attendances;
  String? id;
  int lower;
  int mid;
  int higher;
  String course;
  String location;

  ClassModel({
    required this.location,
    required this.name,
    this.id,
    required this.course,
    required this.lower,
    required this.mid,
    required this.higher,
    this.date,
    this.duration,
    this.attendances,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "date": date,
      "duration": duration,
      "location": location,
      "students": attendances,
      "_id" : id,
      "lower" : lower,
      "mid" : mid,
      "higher" : higher,
      "course" : course,
    };
  }

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      location: json['location'],
      name: json['name'],
      lower: json['lower'],
      id: json['_id'],
      mid: json['mid'],
      higher: json['higher'],
      date: json['date'],
      course: json['course'],
      duration: json['duration'],
      attendances: json['attendance'] != null
          ? List<String>.from(
              json['attendance'])
          : null,
    );
  }
}
