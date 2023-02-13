import 'dart:convert';

List<TodoList> todoListFromJson(String str) =>
    List<TodoList>.from(json.decode(str).map((x) => TodoList.fromJson(x)));

String todoListToJson(List<TodoList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoList {
  TodoList({
    required this.id,
    required this.todoTitle,
    required this.startDate,
    required this.endDate,
  });

  int id;
  String todoTitle;
  DateTime startDate;
  DateTime endDate;

  factory TodoList.fromJson(Map<String, dynamic> json) => TodoList(
        id: json["id"],
        todoTitle: json["todo_title"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo_title": todoTitle,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}
