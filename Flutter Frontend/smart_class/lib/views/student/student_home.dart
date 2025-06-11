import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/api/student_api_controller.dart';
import 'package:smart_class/controller/student_controller.dart';
import 'package:smart_class/models/class_model.dart';
import 'package:smart_class/models/course_model.dart';
import 'package:smart_class/views/student/register_course.dart';
import 'package:smart_class/views/student/student_course_view.dart';

import '../../controller/course/student_course_controller.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final studentController = Get.find<StudentController>();
  StudentApiController apiController = Get.put(StudentApiController(), permanent: true);
  StudentCourseController courseController = Get.put(StudentCourseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello ${studentController.student.value.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            SizedBox(
              height: Get.height * .01,
            ),
            Text("Your Courses: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

                 Obx(() {
                    return studentController.courses.isEmpty
                        ? SizedBox() : ListView.builder(
                        shrinkWrap: true,
                        itemCount: studentController.courses.length,
                        itemBuilder: (context, index) {
                          CourseModel currCourse =
                              studentController.courses[index];
                          return Card(
                            child: ListTile(
                              title: Text(currCourse.name),
                              subtitle: Row(
                                children: [
                                  Text("Id: ${currCourse.courseId}"),
                                  SizedBox(width: Get.width * .01,),
                                  currCourse.duration != null ? Text(currCourse.duration!) : SizedBox(),
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () async {
                                    courseController.setCourse(currCourse);
                                    await courseController.loadClasses();
                                    Get.to(StudentCourseView());
                                  },
                                  icon: Icon(Icons.keyboard_arrow_right)),
                            ),
                          );
                        });
                  })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(RegisterCourse());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget myAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: const Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              child: Center(
                child: Icon(Icons.person),
              ),
            ),
          ),
          Center(
            child: Text(
              "Welcome!",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

}
