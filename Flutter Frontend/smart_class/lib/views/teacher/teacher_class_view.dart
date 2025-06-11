import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/classes/teacher_class_controller.dart';
import 'package:smart_class/controller/teacher_controller.dart';

import '../../models/student_model.dart';

class TeacherClassView extends StatefulWidget {
  const TeacherClassView({super.key});

  @override
  State<TeacherClassView> createState() => _TeacherClassViewState();
}

class _TeacherClassViewState extends State<TeacherClassView> {
  final classController = Get.find<TeacherClassController>();
  final teacherController = Get.find<TeacherController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(classController.myClass.value.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello ${teacherController.teacher.value.name}!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            SizedBox(height: Get.height * .01,),
            Text("Students", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: Get.height * .01,),
            Obx(() {
              return ListView.builder(itemCount: classController.students.length,itemBuilder: (context, index) {
                Map<String, dynamic> currStudent = classController.students[index];
                return Card(
                  child: ListTile(
                    subtitle: Text(currStudent['name']),
                    title: Text("${currStudent['roll']}"),
                  ),
                );
              }, shrinkWrap: true,);
            }),
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
}
