import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GetCurrentLocation {
  /// Retrieves the current location with proper error handling
  static Future<Map<String, dynamic>?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Error!", "Location services are not enabled.");
        return null;
      }

      // Check and request permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Error!", "Location permission denied.");
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("Error!", "Location permission denied permanently.");
        return null;
      }

      // Retrieve the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Return the location data as a Map
      return {
        "longitude": position.longitude,
        "latitude": position.latitude,
      };

    } catch (e) {
      Get.snackbar("Error!", "Failed to get location: $e");
      return null;
    }
  }
}
