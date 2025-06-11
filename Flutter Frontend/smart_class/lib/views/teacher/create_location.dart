import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:smart_class/controller/api/teacher_api_controller.dart';
import 'package:smart_class/controller/teacher_controller.dart';
import 'package:smart_class/models/location_model.dart';
import 'package:smart_class/services/get_current_location.dart';
import 'package:smart_class/views/teacher/location_view.dart';

class CreateLocation extends StatefulWidget {
  const CreateLocation({super.key});

  @override
  State<CreateLocation> createState() => _CreateLocationState();
}

class _CreateLocationState extends State<CreateLocation> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TeacherApiController apiController = TeacherApiController();
  final teacherController = Get.find<TeacherController>();
  Map<String, dynamic>? location;
  Future<void> _getCurrentLocation() async {
    setState(() => isLoading = true);
    location = await GetCurrentLocation.getCurrentLocation();
    setState(() {
      longController.text = location!['longitude'].toString();
      latController.text = location!['latitude'].toString();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = Get.arguments;

    return Scaffold(
      appBar: myAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Form(key: formKey,
              child: Column(
                children: [
                  myTextField("Name", nameController),
                  myTextField("Latitude", latController),
                  myTextField("Longitude", longController),
                  IconButton(
                      onPressed: () async{

                        await _getCurrentLocation();
                      },
                      icon : const Icon(Icons.location_searching_rounded)),
                ],
              ),

            ),
            ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    LocationModel myLocation = LocationModel(
                        name: nameController.text.trim(),
                        longitude: double.parse(longController.text.trim()),
                        teacher: teacherController.teacher.value.id!,
                        latitude: double.parse(latController.text.trim()));
                    final result = await apiController.setLocation(myLocation);
                    LocationModel? currLocation = result['location'];
                    teacherController.teacher.value.locations =
                        result['teacher'];
                    if (currLocation != null) {
                      await teacherController.loadLocations();
                      if(args?['from'] == 'createClass')
                        {
                          Navigator.pop(context);
                        }
                      else{
                        Get.off(LocationView());
                      }
                    }
                  }
                },
                child:
                    isLoading ? CircularProgressIndicator() : Text("Submit")),
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
        "Set Location",
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
