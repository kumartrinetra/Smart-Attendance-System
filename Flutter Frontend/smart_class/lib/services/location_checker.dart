// import 'dart:async';
//
// import 'package:geolocator/geolocator.dart';
// import 'package:smart_class/models/attendance_model.dart';
//
// class LocationChecker{
//
//   final double geofenceRadius = 50.0;
//   Timer? timer;
//
//   int locationChecks = 0;
//   final int requiredChecks = 6;
//   Position? lastLocation;
//
//   void startTrackingAttendance(AttendanceModel attendance)
//   {
//     locationChecks = 0;
//     timer?.cancel();
//
//     timer = Timer.periodic(Duration(minutes: 5), (timer)async {
//       if(locationChecks >= requiredChecks)
//         {
//           timer.cancel();
//           if(locationChecks == requiredChecks)
//             {
//
//             }
//         }
//     });
//   }


// }