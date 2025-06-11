import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/auth/student_auth_controller.dart';
import 'package:smart_class/controller/student_controller.dart';
import 'package:smart_class/models/student_model.dart';
import 'package:smart_class/views/student/register_student.dart';
import 'package:smart_class/views/student/student_home.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  StudentAuthController authController = StudentAuthController();
  StudentController studentController = Get.put(StudentController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Login"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(child: Column(
              children: [
                myTextField("Email", emailController),
                myTextField("Password", passwordController),
              ],
            ), key: formKey,),
            ElevatedButton(onPressed: ()async {
              if(formKey.currentState!.validate())
                {
                  StudentModel? myStudent = await authController.loginStudent(emailController.text.toString(), passwordController.text.toString());
                  if(myStudent != null)
                    {
                      studentController.setStudent(myStudent);
                      await studentController.setCourses();
                      Get.off(StudentHomeScreen());
                    }
                }
            }, child: Text("Submit")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                TextButton(
                    onPressed: () {
                      Get.off(RegisterStudent());
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
