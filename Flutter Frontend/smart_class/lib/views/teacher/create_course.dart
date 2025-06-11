import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_class/controller/api/teacher_api_controller.dart';
import 'package:smart_class/controller/course/teacher_course_controller.dart';
import 'package:smart_class/controller/teacher_controller.dart';
import 'package:smart_class/models/course_model.dart';
import 'package:smart_class/views/teacher/course_view.dart';

class CreateCourse extends StatefulWidget {
  const CreateCourse({super.key});

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  DateTimeRange? dateTimeRange;
  String? timeRange;
  final formKey = GlobalKey<FormState>();
  final teacherController = Get.find<TeacherController>();
  final courseController = Get.find<TeacherCourseController>();
  final apiController = Get.find<TeacherApiController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Form(
                key: formKey,
                child: Column(
                  children: [
                    myTextField("Course Name", nameController),
                    myTextField("Course ID", idController),
                    IconButton(
                        onPressed: () async {
                          final DateTimeRange? picked =
                              await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(2025),
                                  lastDate: DateTime(2030));
                          if (picked != null) {
                            dateTimeRange = picked;
                            timeRange = DateFormat('MMM')
                                    .format(dateTimeRange!.start) +
                                " " +
                                DateFormat('yyyy')
                                    .format(dateTimeRange!.start) +
                                " to " +
                                DateFormat('MMM').format(dateTimeRange!.end) +
                                " " +
                                DateFormat('yyyy').format(dateTimeRange!.end);
                          }
                        },
                        icon: Icon(Icons.calendar_month))
                  ],
                )),
            ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    CourseModel myCourse = CourseModel(
                        name: nameController.text.trim().toString(),
                        courseId: idController.text.trim().toString(),
                        teacher: teacherController.teacher.value.id!,
                        duration: timeRange);
                    Map<String, dynamic> result =
                        await apiController.createCourse(myCourse);
                    CourseModel? newCourse = result['course'];

                    teacherController.teacher.value.courses = result['teacher'];
                    print(teacherController.teacher.value.courses);
                    if (newCourse != null && result['teacher'] != null) {
                      courseController.setCourse(newCourse);
                      await teacherController.loadCourses();
                      Get.off(TeacherCourseView());
                    }
                  }
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget myAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: Center(
          child: Text(
        "Create Course",
        style: TextStyle(color: Colors.white),
      )),
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
