import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/api/student_api_controller.dart';
import 'package:smart_class/models/attendance_model.dart';
import 'package:smart_class/models/class_model.dart';
import 'package:smart_class/models/location_model.dart';

class StudentClassController extends GetxController{

  var myClass = ClassModel(location: "", name: "", course: "", lower: 0, mid: 0, higher: 0).obs;
  var attendance = <AttendanceModel>[].obs;
  var location = LocationModel(name: "", longitude: 0, latitude: 0, teacher: "").obs;
  StudentApiController apiController = Get.put(StudentApiController());

  Future<void> loadAttendance() async
  {
    if(myClass.value.attendances != null && myClass.value.attendances!.isNotEmpty)
      {
        final result = await apiController.getAttendances(myClass.value.attendances!);
        attendance.assignAll(result);
      }

  }

  Future<void> loadLocation() async
  {
    final result = await apiController.getLocation(myClass.value.location);
    location.value = result;
  }

  bool attendanceMarked(String studentId)
  {
    return attendance.any((att) => att.student == studentId);
  }

  bool checkDeviceId(String device)
  {
    return attendance.any((att) => att.deviceId == device);
  }

  void setClass(ClassModel meraClass)
  {
    myClass.value = meraClass;
  }

  bool isWithinRange(Map<String, dynamic> s_location) {
    // Ensure both locations are treated as double values
    double studentLat = (s_location['latitude'] as num).toDouble();
    double studentLng = (s_location['longitude'] as num).toDouble();
    double classLat = (location.value.latitude as num).toDouble();
    double classLng = (location.value.longitude as num).toDouble();

    // Calculate distance
    double distance = Geolocator.distanceBetween(
      classLat,
      classLng,
      studentLat,
      studentLng,
    );

    // Return whether distance is within 50m
    return distance <= 50;
  }

  bool initiateAttendance()
  {
    int currTime = DateTime.now().millisecondsSinceEpoch;
    if(currTime < myClass.value.lower)
      {
        Get.snackbar("Too early :(", "Class has not satrted yet");
        return false;
      }
    if(currTime >= myClass.value.lower && currTime <= myClass.value.mid)
      {
        return true;
      }
    if(currTime >= myClass.value.mid && currTime <= myClass.value.higher)
      {
        Get.snackbar("You are late :(", "You are coming class after 30 minutes lecture has started");
        return false;
      }
    Get.snackbar("You missed the class :(", "Class is over");
    return false;
  }

}