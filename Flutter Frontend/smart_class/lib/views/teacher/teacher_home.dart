import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/api/teacher_api_controller.dart';
import 'package:smart_class/controller/course/teacher_course_controller.dart';
import 'package:smart_class/controller/teacher_controller.dart';
import 'package:smart_class/models/course_model.dart';
import 'package:smart_class/views/teacher/course_view.dart';
import 'package:smart_class/views/teacher/create_course.dart';

import 'package:smart_class/views/teacher/locations.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final teacherController = Get.find<TeacherController>();
  TeacherApiController apiController = Get.put(TeacherApiController(), permanent: true);
  TeacherCourseController courseController = Get.put(TeacherCourseController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Hello! ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Text(teacherController.teacher.value.name,
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
              ],
            ),
            SizedBox(height: Get.height * .03,),
            const Text(
              "Your Courses",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            SizedBox(height: Get.height * .01,),

                 Obx(() {
                  return teacherController.courses.isEmpty
                   ?  SizedBox() :
                       ListView.builder(
                          shrinkWrap: true,
                          itemCount: teacherController.courses.length,
                          itemBuilder: (context, index) {
                            CourseModel currCourse = teacherController.courses[index];
                            return Card(
                              child: ListTile(
                                title: Text(currCourse.name),
                                subtitle: Text("Id: ${currCourse.courseId}"),
                                trailing: IconButton(
                                    onPressed: () {
                                      courseController.setCourse(currCourse);
                                      courseController.loadClasses();
                                      Get.to(TeacherCourseView());
                                    },
                                    icon: Icon(Icons.keyboard_arrow_right)),
                              ),
                            );
                          });
                })
            //Courses List
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CreateCourse());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget myAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            child: Center(
              child: Icon(Icons.person),
            ),
          ),
          Text(
            "Welcome!",
            style: TextStyle(color: Colors.white),
          ),
          myMenuList("Saved Locations"),
        ],
      ),
    );
  }

  PopupMenuButton myMenuList(String title1) {
    return PopupMenuButton<int>(
      iconColor: Colors.white,
        onSelected: (value) async {
          if (value == 0) {

            Get.to(LocationScreen());
          }
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Container(
                  child: Text(title1),
                ),
                value: 0,
              ),
            ]);
  }
}
