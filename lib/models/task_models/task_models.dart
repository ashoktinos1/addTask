import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModels {
  String? id;
  String? taskName;
  String? taskType;
  List<String>? members;
  String? startDate;
  String? endDate;
  bool? select;

  TaskModels(
      {this.taskName,
      this.endDate,
      this.members,
      this.startDate,
      this.taskType,
      this.id
      ,this.select});

  factory TaskModels.fromjson(DocumentSnapshot json) {
    return TaskModels(
        taskName: json["taskName"],
        taskType: json["taskType"],
        members: List<String>.from(json["members"].map((e) => e)),
        startDate: json["startDate"],
        endDate: json["endDate"],
        id: json.id);
  }
  //   instructions: List<String>.from(json["instructions"].map((x) => x)),
  // List<dynamic>.from(instructions.map((x) => x)),

  Map<String, dynamic> tojson() {
    return {
      "taskName": taskName,
      "taskType": taskType,
      "members": List<dynamic>.from(members!.map((e) => e)),
      "startDate": startDate,
      "endDate": endDate,
    };
  }
}
