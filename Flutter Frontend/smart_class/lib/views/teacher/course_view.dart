import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/classes/teacher_class_controller.dart';
import 'package:smart_class/controller/course/teacher_course_controller.dart';
import 'package:smart_class/models/class_model.dart';
import 'package:smart_class/views/teacher/create_class.dart';
import 'package:smart_class/views/teacher/teacher_class_view.dart';

import '../../controller/teacher_controller.dart';

class TeacherCourseView extends StatefulWidget {
  const TeacherCourseView({super.key});

  @override
  State<TeacherCourseView> createState() => _TeacherCourseViewState();
}

class _TeacherCourseViewState extends State<TeacherCourseView> {
  final courseController = Get.find<TeacherCourseController>();
  TeacherClassController classController = Get.put(TeacherClassController());
  final teacherController = Get.find<TeacherController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(courseController.course.value.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Course Code: ${courseController.course.value.courseId}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: Get.height * .01,),
            Text("Duration: ${courseController.course.value.duration}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: Get.height * .01,),
            Text("Classes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: Get.height * .01,),
            Obx(() {
              return Card(
                child: ListView.builder(itemCount: courseController.classes.length,itemBuilder: (context, index) {
                  ClassModel currClass = courseController.classes[index];
                  return ListTile(
                    title: Text(currClass.name),
                    subtitle: Text("Date: ${currClass.date}  Time: ${currClass.duration}"),
                    trailing: IconButton(onPressed: ()async{
                      classController.setClass(currClass);
                      await classController.loadStudents();
                      Get.to(TeacherClassView());
                    }, icon: Icon(Icons.keyboard_arrow_right)),
                  );
                }, shrinkWrap: true,),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(CreateClass());
      }, child: Icon(Icons.add),),
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
