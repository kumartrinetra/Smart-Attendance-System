import 'package:get/get.dart';
import 'package:smart_class/controller/api/teacher_api_controller.dart';
import 'package:smart_class/models/class_model.dart';

class TeacherClassController extends GetxController{
  var myClass = ClassModel(location: "", name: "", course: "", lower: 0, mid: 0, higher: 0).obs;

  var students = <Map<String, dynamic>>[].obs;

  TeacherApiController apiController = Get.put(TeacherApiController());

  Future<void> loadStudents() async
  {
    print("hello");
    if(myClass.value.attendances != null && myClass.value.attendances!.isNotEmpty) {
      final result = await apiController.getClassStudents(myClass.value.attendances!);
      students.assignAll(result);
    }
    else{
      students.clear();
    }
  }

  void setClass(ClassModel newClass)
  {
    print("Hello");
    print(newClass.attendances);
    myClass.value = newClass;
  }

}