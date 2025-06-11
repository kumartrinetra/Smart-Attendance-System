import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UniqueDeviceId{
  static Future<String> getUUID() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_uuid');

    if(deviceId == null)
      {
        deviceId = const Uuid().v4();
        await prefs.setString('device_uuid', deviceId);
        print("Newly generated device id: ${deviceId}");
      }
    else{
      print("Existing device id: ${deviceId}");
    }

    return deviceId;
  }
}