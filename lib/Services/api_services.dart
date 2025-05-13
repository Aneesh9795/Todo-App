import 'dart:convert';
import "package:http/http.dart" as http;
import '../models/task_model.dart';

class ApiService {
  final String baseUrl = "https://your-api.com"; // change this

  Future<List<TaskModel>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      throw Exception('Tasks load nahi ho paye');
    }
  }

  Future<void> createTask(TaskModel task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Task create nahi ho paya');
    }
  }
}
