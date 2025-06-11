class LocationModel{
  String name;
  double latitude;
  String?  id;
  double longitude;
  String teacher;
  LocationModel({
    required this.name,
    required this.longitude,
    this.id,
    required this.latitude,
    required this.teacher,
});

  Map<String, dynamic> toJson()
  {
    return {
      "name" : name,
      "longitude" : longitude,
      "_id" : id,
      "latitude" : latitude,
      "teacher" : teacher,
    };
  }

factory LocationModel.fromJson(Map<String, dynamic> json){
    return LocationModel(name: json['name'], longitude: json['longitude'], latitude: json['latitude'], teacher: json['teacher'], id: json['_id']);
}
}