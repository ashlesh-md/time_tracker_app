import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TasksService {
  static const String _baseUrl = 'https://api.todoist.com/rest/v2/tasks';
  static const String _apiKey = 'c14ea7233c5c099a9ec5b2832a593470c737491a';

  static Future<List<Task>> fetchTasks([String id = '8240336070']) async {
    final uri = Uri.parse('$_baseUrl?id=$id');
    final headers = {
      'Authorization': 'Bearer $_apiKey',
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> tasksJson = json.decode(response.body);
        log('task Data : $tasksJson');
        return tasksJson.map((json) => Task.fromJson(json)).toList();
      } else {
        log('Error fetching tasks: ${response.statusCode}');
        throw Exception('Failed to load tasks');
      }
    } on SocketException catch (e) {
      log('Network error: $e');
      throw Exception('Network error: Failed to load tasks');
    } on HttpException catch (e) {
      log('HTTP error: $e');
      throw Exception('HTTP error: Failed to load tasks');
    } on FormatException catch (e) {
      log('Format error: $e');
      throw Exception('Format error: Failed to parse tasks');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Unexpected error: Failed to load tasks');
    }
  }

  static Future<void> addTask(String content, String taskDescription,
      [String projectId = '2336825066']) async {
    final uri = Uri.parse(_baseUrl);
    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      'project_id': projectId,
      'content': content,
      'description': taskDescription
    });

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Task added successfully');
      } else {
        log('Error adding task: ${response.statusCode}');
        throw Exception('Failed to add task: ${response.body}');
      }
    } on SocketException catch (e) {
      log('Network error: $e');
      throw Exception('Network error: Failed to add task');
    } on HttpException catch (e) {
      log('HTTP error: $e');
      throw Exception('HTTP error: Failed to add task');
    } on FormatException catch (e) {
      log('Format error: $e');
      throw Exception('Format error: Failed to parse response');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Unexpected error: Failed to add task');
    }
  }

  static Future<void> deleteTask(String taskId) async {
    final uri = Uri.parse('$_baseUrl/$taskId');
    final headers = {
      'Authorization': 'Bearer $_apiKey',
    };

    try {
      final response = await http.delete(uri, headers: headers);

      if (response.statusCode == 204) {
        log('Task deleted successfully');
      } else {
        log('Error deleting task: ${response.statusCode}');
        throw Exception('Failed to delete task: ${response.body}');
      }
    } on SocketException catch (e) {
      log('Network error: $e');
      throw Exception('Network error: Failed to delete task');
    } on HttpException catch (e) {
      log('HTTP error: $e');
      throw Exception('HTTP error: Failed to delete task');
    } on FormatException catch (e) {
      log('Format error: $e');
      throw Exception('Format error: Failed to parse response');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Unexpected error: Failed to delete task');
    }
  }

  static Future<void> editTask(
      String taskId, String newContent, String description) async {
    final uri = Uri.parse('$_baseUrl/$taskId');
    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
    };
    final body =
        json.encode({'content': newContent, 'description': description});

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 204) {
        log('Task edited successfully');
      } else {
        log('Error editing task: ${response.statusCode}');
        throw Exception('Failed to edit task: ${response.body}');
      }
    } on SocketException catch (e) {
      log('Network error: $e');
      throw Exception('Network error: Failed to edit task');
    } on HttpException catch (e) {
      log('HTTP error: $e');
      throw Exception('HTTP error: Failed to edit task');
    } on FormatException catch (e) {
      log('Format error: $e');
      throw Exception('Format error: Failed to parse response');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Unexpected error: Failed to edit task');
    }
  }

  static Future<void> completeTask(String taskId) async {
    final uri = Uri.parse('$_baseUrl/$taskId/close');
    final headers = {
      'Authorization': 'Bearer $_apiKey',
    };

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 204) {
        log('Task completed successfully');
      } else {
        log('Error completing task: ${response.statusCode}');
        throw Exception('Failed to complete task: ${response.body}');
      }
    } on SocketException catch (e) {
      log('Network error: $e');
      throw Exception('Network error: Failed to complete task');
    } on HttpException catch (e) {
      log('HTTP error: $e');
      throw Exception('HTTP error: Failed to complete task');
    } on FormatException catch (e) {
      log('Format error: $e');
      throw Exception('Format error: Failed to parse response');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Unexpected error: Failed to complete task');
    }
  }

  static Future<void> saveTaskToSharedPreferences(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final store = {'time': 0, 'status': 'To Do', 'isCompleted': false};
    await prefs.setString('${task.id}', jsonEncode(store));
  }
}
