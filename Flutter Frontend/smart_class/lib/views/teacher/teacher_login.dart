import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/auth/teacher_auth_controller.dart';
import 'package:smart_class/models/teacher_model.dart';
import 'package:smart_class/views/student/register_student.dart';
import 'package:smart_class/views/teacher/register_teacher.dart';
import 'package:smart_class/views/teacher/teacher_home.dart';

import '../../controller/teacher_controller.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TeacherAuthController authController = TeacherAuthController();
  TeacherController teacherController =
      Get.put(TeacherController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Login"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  myTextField("Email", emailController),
                  myTextField("Password", passwordController),
                ],
              ),
              key: formKey,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    TeacherModel? teacher = await authController.loginTeacher(
                        emailController.text.toString(),
                        passwordController.text.toString());
                    if (teacher != null) {
                      teacherController.setTeacher(teacher);
                      if (teacherController.teacher.value.locations != null &&
                          teacherController
                              .teacher.value.locations!.isNotEmpty) {
                        await teacherController.loadLocations();
                      }
                      if (teacherController.teacher.value.courses != null &&
                          teacherController.teacher.value.courses!.isNotEmpty) {
                        print(teacherController.teacher.value.courses);
                        await teacherController.loadCourses();
                      }

                      Get.off(TeacherHomeScreen());
                    }
                  }
                },
                child: Text("Submit")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                TextButton(
                    onPressed: () {
                      Get.off(RegisterTeacher());
                    },
                    child: Text(
                      "Signup",
                      style: TextStyle(color: Colors.deepPurple),
                    )),
              ],
            ),
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
