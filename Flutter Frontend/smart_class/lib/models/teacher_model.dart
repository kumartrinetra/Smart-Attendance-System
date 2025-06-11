

class TeacherModel {
  String name;
  String email;
  String? id;
  int contact;
  bool isTeacher = true;
  String password;
  String? profilePic;
  List<String>? locations;
  List<String>? courses;

  TeacherModel({
    required this.name,
    required this.email,
    required this.password,
    required this.contact,
    this.isTeacher = true,
    this.id,
    this.profilePic,
    this.locations,
    this.courses,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "isTeacher" : isTeacher,
      "password" : password,
      "contact": contact,
      "profilePic": profilePic,
      "locations": locations,
      "courses": courses,
    };
  }

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      isTeacher: json['isTeacher'],
      name: json['name'],
      password: json['password'],
      email: json['email'],
      contact: json['contact'],
      id: json['_id'],
      profilePic: json['profilePic'] ?? "",
      locations: json['locations'] != null
          ? List<String>.from(json['locations']
              )
          : null,
      courses: json['courses'] != null
          ? List<String>.from(
              json['courses'])
          : null,
    );
  }
}
