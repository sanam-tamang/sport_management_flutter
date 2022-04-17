//taken product data contains the name and taken product only
class Student {
  String studentID;
  String studentName;
  String studentFaculty;
  String takenProduct;
  String date;

  Student(
      {required this.studentID,
      required this.studentName,
      required this.studentFaculty,
      required this.takenProduct,
      required this.date});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentID: json['studentID'],
      studentName: json['studentName'],
      studentFaculty: json['studentFaculty'],
      takenProduct: json['takenProduct'],
      date: json['takenDate'],
    );
  }
}
