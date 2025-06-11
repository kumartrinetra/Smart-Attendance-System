import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/api/student_api_controller.dart';
import 'package:smart_class/controller/classes/student_class_controller.dart';
import 'package:smart_class/models/attendance_model.dart';
import 'package:smart_class/services/device_uuid.dart';
import 'package:smart_class/services/get_current_location.dart';

import '../../controller/student_controller.dart';


class StudentClassView extends StatefulWidget {
  const StudentClassView({super.key});

  @override
  State<StudentClassView> createState() => _StudentClassViewState();
}

class _StudentClassViewState extends State<StudentClassView> {
  bool isLoading = false;
  final classController = Get.find<StudentClassController>();
  final studentController = Get.find<StudentController>();
  final apiController = Get.find<StudentApiController>();

  Future<Map<String, dynamic>?> _getCurrentLocation() async
  {

    Map<String, dynamic>? location =  await GetCurrentLocation.getCurrentLocation();

    return location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(classController.myClass.value.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hello ${studentController.student.value.name}!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            SizedBox(height: Get.height * .01,),
            ElevatedButton(onPressed: () async{
              if(classController.initiateAttendance())
                {
                  setState(() {
                    isLoading = true;
                  });
                  if(!classController.attendanceMarked(studentController.student.value.id!))
                  {
                    String deviceId =  await UniqueDeviceId.getUUID();
                    if(!classController.checkDeviceId(deviceId))
                    {

                      Map<String, dynamic>? location = await _getCurrentLocation();
                      if(location != null)
                      {
                        if(classController.isWithinRange(location))
                        {
                          AttendanceModel attendance = AttendanceModel(student: studentController.student.value.id!, myClass: classController.myClass.value.id!, deviceId: deviceId);
                          Map<String, dynamic>? result = await apiController.markAttendance(attendance);
                          if(result != null)
                            {
                              classController.myClass.value.attendances = result['list'];
                              await classController.loadAttendance();
                              setState(() {
                                isLoading = false;
                              });
                            }
                          else{
                            Get.snackbar("Error!", "Some error occured while marking your attendance");
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                        else{
                          Get.snackbar("Error!", "You are not inside class. :(");
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                      else{
                        Get.snackbar("Error!", "Could not capture your location :(");
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                    else{
                      Get.snackbar("Duplicate Attendance!", "An attendance already marked using this device");
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                  else{
                    Get.snackbar("Already Marked!", "You have already marked your attendance");
                    setState(() {
                      isLoading = false;
                    });
                  }
                }

            }, child: isLoading ? const CircularProgressIndicator() :  const Text("Mark Presence")),
            
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
