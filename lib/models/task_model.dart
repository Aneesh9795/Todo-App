import 'package:flutter/material.dart';

class TaskModel {
  String title;
  String description;
  DateTime date;
  TimeOfDay time;
  String priority;
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
    this.isCompleted = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].split(':')[0]),
        minute: int.parse(json['time'].split(':')[1]),
      ),
      priority: json['priority'],
      isCompleted: json['isCompleted'] ?? false, // default false if null
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'time': '${time.hour}:${time.minute}',
    'priority': priority,
    'isCompleted': isCompleted,
  };
}
