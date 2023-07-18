class Students {
  String? key;
  StudentsData? studentData;
  Students({this.key, this.studentData});
}

class StudentsData {
  String? name;
  String? age;
  String? course;
  String? regno;

  StudentsData({this.age, this.course, this.name, this.regno});

  StudentsData.fromJson(Map<dynamic, dynamic> json) {
    name = json["name"];
    age = json["ages"];
    course = json["course"];
    regno = json["regno"];
  }
}
