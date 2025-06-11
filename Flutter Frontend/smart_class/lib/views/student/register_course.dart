import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/api/student_api_controller.dart';
import 'package:smart_class/controller/student_controller.dart';
import 'package:smart_class/models/course_model.dart';
import 'package:smart_class/views/student/student_course_view.dart';

import '../../controller/course/student_course_controller.dart';

class RegisterCourse extends StatefulWidget {
  const RegisterCourse({super.key});

  @override
  State<RegisterCourse> createState() => _RegisterCourseState();
}

class _RegisterCourseState extends State<RegisterCourse> {
  TextEditingController idController = TextEditingController();
  final studentController = Get.find<StudentController>();
  final apiController = Get.find<StudentApiController>();
  StudentCourseController courseController = Get.put(StudentCourseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("New Course"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            myTextField("Course ID", idController),
            ElevatedButton(onPressed: () async {
              Map<String, dynamic> result = await apiController.registerCourse(idController.text.trim().toString(), studentController.student.value.id!);
              CourseModel? newCourse =  result['myCourse'];
              studentController.student.value.courses = result['course_list'];
              if(newCourse != null)
                {
                  courseController.setCourse(newCourse);
                  await studentController.setCourses();
                  await courseController.loadClasses();

                  Get.off(StudentCourseView());
                }
            }, child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget myAppBar(String title_name) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: Center(
        child: Text(
          title_name,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget myTextField(String name, TextEditingController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter ${name}";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: name,
          ),
        ),
        SizedBox(
          height: Get.height * .02,
        ),
      ],
    );
  }
}
