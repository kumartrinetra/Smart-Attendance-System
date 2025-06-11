import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/classes/student_class_controller.dart';
import 'package:smart_class/controller/course/student_course_controller.dart';
import 'package:smart_class/views/student/student_class_view.dart';

import '../../models/class_model.dart';

class StudentCourseView extends StatefulWidget {
  const StudentCourseView({super.key});

  @override
  State<StudentCourseView> createState() => _StudentCourseViewState();
}

class _StudentCourseViewState extends State<StudentCourseView> {
  final courseController = Get.find<StudentCourseController>();
  StudentClassController classController = Get.put(StudentClassController());
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
                    trailing: SizedBox(width: 60,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: giveColor(currClass),
                          ),
                          IconButton(onPressed: ()async{
                            classController.setClass(currClass);
                            await classController.loadAttendance();
                            await classController.loadLocation();
                            Get.to(StudentClassView());
                          }, icon: Icon(Icons.keyboard_arrow_right)),
                        ],
                      ),
                    ),
                  );
                }, shrinkWrap: true,),
              );
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
  Color giveColor(ClassModel currClass)
  {
    if(DateTime.now().millisecondsSinceEpoch < currClass.lower)
    {
      return Colors.green;
    }
    else if(DateTime.now().millisecondsSinceEpoch >= currClass.lower && DateTime.now().millisecondsSinceEpoch <= currClass.higher)
    {
      return Colors.yellow;
    }
    return Colors.red;
  }
}
