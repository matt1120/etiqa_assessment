import 'dart:convert';

List<TodoList> todoListFromJson(String str) =>
    List<TodoList>.from(json.decode(str).map((x) => TodoList.fromJson(x)));

String todoListToJson(List<TodoList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoList {
  TodoList(
      {required this.id,
      required this.todoTitle,
      required this.startDate,
      required this.endDate,
      required this.status});

  int id;
  String todoTitle;
  String startDate;
  String endDate;
  String status;

  factory TodoList.fromJson(Map<String, dynamic> json) => TodoList(
        id: json["id"],
        todoTitle: json["todo_title"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo_title": todoTitle,
        "start_date": startDate,
        "end_date": endDate,
        "status": status
      };
}
