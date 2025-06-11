import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/auth/teacher_auth_controller.dart';
import 'package:smart_class/models/teacher_model.dart';
import 'package:smart_class/views/teacher/teacher_home.dart';
import 'package:smart_class/views/teacher/teacher_login.dart';

import '../../controller/teacher_controller.dart';

class RegisterTeacher extends StatefulWidget {
  const RegisterTeacher({super.key});

  @override
  State<RegisterTeacher> createState() => _RegisterTeacherState();
}

class _RegisterTeacherState extends State<RegisterTeacher> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TeacherAuthController authController = TeacherAuthController();
  TeacherController teacherController = Get.put(TeacherController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Sign Up"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Form(
                key: formKey,
                child: Column(
                  children: [
                    myTextField("Name", nameController),
                    myTextField("Email", emailController),
                    myTextField("Contact No.", contactController),
                    myTextField("Password", passwordController)
                  ],
                )),
            ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    TeacherModel teacher = TeacherModel(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        contact: int.parse(contactController.text.trim()));
                    TeacherModel? newTeacher =
                        await authController.registerTeacher(teacher);
                    if (newTeacher != null) {
                      teacherController.setTeacher(newTeacher);
                      Get.off(TeacherHomeScreen());
                    }
                  }
                },
                child: Text("Submit")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                TextButton(
                    onPressed: () {
                      Get.off(TeacherLogin());
                    },
                    child: Text(
                      "Login",
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
