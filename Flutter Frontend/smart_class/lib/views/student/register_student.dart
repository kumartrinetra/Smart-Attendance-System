import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/auth/student_auth_controller.dart';
import 'package:smart_class/controller/student_controller.dart';
import 'package:smart_class/controller/teacher_controller.dart';
import 'package:smart_class/models/student_model.dart';
import 'package:smart_class/views/student/student_home.dart';
import 'package:smart_class/views/student/student_login.dart';

class RegisterStudent extends StatefulWidget {
  const RegisterStudent({super.key});

  @override
  State<RegisterStudent> createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  StudentAuthController authController = StudentAuthController();
  StudentController studentController = Get.put(StudentController(), permanent: true);
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
                    myTextField("Roll No.", rollController),
                    myTextField("Email", emailController),
                    myTextField("Contact No.", contactController),
                    myTextField("Password", passwordController)
                  ],
                )),
            ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate())  {
                    StudentModel student = StudentModel(
                        name: nameController.text.trim(),
                        roll: int.parse(rollController.text.trim()),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        contact: int.parse(contactController.text.trim()));
                    StudentModel? newStudent =  await authController.registerStudent(student);
                    if(newStudent != null) {
                      studentController.setStudent(newStudent);
                      await studentController.setCourses();
                      Get.off(StudentHomeScreen());
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
                      Get.off(StudentLogin());
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
