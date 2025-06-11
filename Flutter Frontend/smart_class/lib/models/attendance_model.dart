class AttendanceModel{
  String deviceId;
  String student;
  String myClass;

  AttendanceModel({
    required this.student,
    required this.myClass,
    required this.deviceId,
});

  Map<String, dynamic> toJson()
  {
    return {
      "deviceId" : deviceId,
      "student" : student,
      "myClass" :  myClass
    };
  }

  factory AttendanceModel.fromJson(Map<String, dynamic> json)
  {
    return AttendanceModel(student: json['student'],  myClass: json['myClass'], deviceId: json['deviceId']);
  }
}