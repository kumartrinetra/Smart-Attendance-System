import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_class/controller/api/teacher_api_controller.dart';
import 'package:smart_class/controller/classes/teacher_class_controller.dart';
import 'package:smart_class/controller/course/teacher_course_controller.dart';
import 'package:smart_class/controller/teacher_controller.dart';
import 'package:smart_class/models/class_model.dart';
import 'package:smart_class/views/teacher/create_location.dart';
import 'package:smart_class/views/teacher/teacher_class_view.dart';

import '../../models/location_model.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final FocusNode _locationFocus = FocusNode();
  List<LocationModel> _filteredLocations = [];
  bool _showSuggestions = false;
  DateTime? selctedDate;
  TimeOfDay? startTime;
  LocationModel? selectedLocation;
  TimeOfDay? endTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locationFocus.addListener(() {
      setState(() {
        _showSuggestions = _locationFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _locationFocus.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  final courseController = Get.find<TeacherCourseController>();
  TeacherClassController classController = Get.put(TeacherClassController());
  final apiController = Get.find<TeacherApiController>();
  TextEditingController locationController = TextEditingController();

  final teacherController = Get.find<TeacherController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Create Class"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Form(
                key: formKey,
                child: Column(
                  children: [
                    myTextField("Name"),
                    Column(
                      children: [
                        myLocationField("Location", locationController),
                        if (_showSuggestions && _filteredLocations.isNotEmpty)
                          Container(
                            constraints: BoxConstraints(
                                maxHeight: Get.height * .2, minHeight: 0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _filteredLocations.length,
                                itemBuilder: (context, index) {
                                  LocationModel currLocation =
                                      _filteredLocations[index];
                                  return GestureDetector(
                                    onTapDown: (_) {
                                      locationController.text =
                                          currLocation.name;
                                      selectedLocation = currLocation;
                                      setState(() {
                                        _showSuggestions = false;
                                      });
                                    },
                                    child: ListTile(
                                      title: Text(currLocation.name),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                              "Latitude: ${currLocation.latitude}"),
                                          SizedBox(
                                            width: Get.width * .02,
                                          ),
                                          Text(
                                              "Longitude: ${currLocation.longitude}")
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                      ],
                    ),
                    ListTile(
                      title: const Text("Select Class Date"),
                      subtitle: Text(selctedDate != null
                          ? DateFormat('yyyy-MM-dd').format(selctedDate!)
                          : "No date selected"),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: pickDate,
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    ListTile(
                      title: const Text("Start Time"),
                      subtitle: Text(
                        startTime != null
                            ? startTime!.format(context)
                            : "No start time selected",
                      ),
                      trailing: const Icon(Icons.access_time),
                      onTap: pickStartTime,
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    ListTile(
                      title: const Text("End Time"),
                      subtitle: Text(
                        endTime != null
                            ? endTime!.format(context)
                            : "No end time selected",
                      ),
                      trailing: const Icon(Icons.access_time),
                      onTap: pickEndTime,
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                  ],
                )),
            ElevatedButton(
                onPressed: () async{
                  if (selectedLocation != null &&
                      selctedDate != null &&
                      startTime != null &&
                      endTime != null) {
                    DateTime startdateTime = DateTime(
                        selctedDate!.year,
                        selctedDate!.month,
                        selctedDate!.day,
                        startTime!.hour,
                        startTime!.minute);
                    DateTime enddateTime = DateTime(
                        selctedDate!.year,
                        selctedDate!.month,
                        selctedDate!.day,
                        endTime!.hour,
                        endTime!.minute);
                    int low = startdateTime.millisecondsSinceEpoch;
                    int mid = startdateTime
                        .add(const Duration(minutes: 30))
                        .millisecondsSinceEpoch;
                    int high = enddateTime.millisecondsSinceEpoch;
                    ClassModel newClass = ClassModel(
                        location: selectedLocation!.id!,
                        name:
                            "Lecture No. ${courseController.course.value.classes!.length+1}",
                        course: courseController.course.value.id!,
                        lower: low,
                        date: getFormattedDate(),
                        duration: getFormattedTime(),
                        mid: mid,
                        higher: high);
                    final result = await apiController.createClass(newClass);
                    final nayaClass = result['class'];
                    courseController.course.value.classes = result['class_list'];
                    await courseController.loadClasses();
                    classController.setClass(nayaClass);
                    Get.off(TeacherClassView());
                  }
                },
                child: Text("Submit")),
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

  Widget myTextField(String name) {
    return Column(
      children: [
        TextFormField(
          initialValue: "Lecture No. ${courseController.classes.length + 1}",
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

  Widget myLocationField(String name, TextEditingController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          focusNode: _locationFocus,
          onChanged: FilterLocations,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter ${name}";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
                onPressed: () async {
                  int prevLen = teacherController.locations.length;
                  await Get.to(() => CreateLocation(), arguments: {'from': 'createClass'});
                  if(prevLen < teacherController.locations.length)
                    {
                      locationController.text = teacherController.locations.last.name;
                      selectedLocation = teacherController.locations.last;
                      setState(() {

                      });
                    }
                }, icon: Icon(Icons.location_searching_rounded)),
            hintText: name,
          ),
        ),
        SizedBox(
          height: Get.height * .02,
        ),
      ],
    );
  }

  void FilterLocations(String query) {
    setState(() {
      _filteredLocations = query.isEmpty
          ? []
          : teacherController.locations
              .where((location) =>
                  location.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
        initialDate: selctedDate ?? DateTime.now());
    if (pickedDate != null) {
      setState(() {
        selctedDate = pickedDate;
      });
    }
  }

  Future<void> pickStartTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: startTime ?? TimeOfDay.now());
    if (pickedTime != null) {
      setState(() {
        startTime = pickedTime;
      });
    }
  }

  Future<void> pickEndTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: endTime ?? TimeOfDay.now());
    if (pickedTime != null) {
      if (startTime != null &&
          (pickedTime.hour < startTime!.hour ||
              (pickedTime.hour == startTime!.hour &&
                  pickedTime.minute <= startTime!.minute))) {
        Get.snackbar("Invalid Time", "End time must greater than start time");
        return;
      }
      setState(() {
        endTime = pickedTime;
      });
    }
  }

  String getFormattedDate() {
    if (selctedDate == null) {
      Get.snackbar("Date not selected", "Select date");
      return "";
    }
    String date = DateFormat('dd/MM/yyyy').format(selctedDate!);
    return date;
  }

  String getFormattedTime() {
    if (startTime == null) {
      Get.snackbar("Start time not selected", "Select start time");
      return "";
    }
    if (endTime == null) {
      Get.snackbar("End time not selected", "Select end time");
      return "";
    }

    String time = "${startTime!.format(context)} - ${endTime!.format(context)}";
    return time;
  }
}
