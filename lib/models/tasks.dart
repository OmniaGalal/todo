import 'package:todoapp/models/tasks.dart';

class Task {
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;
  Task(
      {this.id = "",
      required this.title,
      required this.date,
      required this.description,
      this.isDone = false});
  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date.millisecondsSinceEpoch,
      "isDone": isDone
    };
  }

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data["id"],
            title: data["title"],
            description: data["description"],
            date: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
            isDone: data["isDone"]);
}
