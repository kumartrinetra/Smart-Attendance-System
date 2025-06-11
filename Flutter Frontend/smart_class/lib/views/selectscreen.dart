import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';

import 'package:smart_class/views/student/register_student.dart';
import 'package:smart_class/views/teacher/register_teacher.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You are a: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: Get.height * .02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  Get.off(RegisterTeacher());
                }, child: Text("Teacher")),
                SizedBox(width: Get.width * .05,),
                ElevatedButton(onPressed: (){
                  Get.off(RegisterStudent());
                }, child: Text("Student")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
