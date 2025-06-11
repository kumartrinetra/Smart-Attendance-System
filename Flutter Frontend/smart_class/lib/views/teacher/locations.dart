import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/models/location_model.dart';
import 'package:smart_class/views/teacher/create_location.dart';

import '../../controller/api/teacher_api_controller.dart';
import '../../controller/teacher_controller.dart';
import '../../models/course_model.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final teacherController = Get.find<TeacherController>();
  TeacherApiController apiController = TeacherApiController();
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
              "Your Locations",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            SizedBox(height: Get.height * .01,),
            teacherController.teacher.value.courses!.isEmpty
                ? SizedBox()
                : Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: teacherController.locations.length,
                      itemBuilder: (context, index) {
                        LocationModel currLocation = teacherController.locations[index];
                        return Card(
                          child: ListTile(
                            title: Text(currLocation.name),
                            subtitle: Row(
                              children: [
                                Text("Latitude:  + ${currLocation.latitude}" ),
                                SizedBox(width: Get.width * .02,),
                                Text("Longitude:  + ${currLocation.longitude}" ),
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {},
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
          Get.to(CreateLocation());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget myAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: Center(
        child: Text(
          "Welcome!",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }


}
