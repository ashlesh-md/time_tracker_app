import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../services/tasks_service.dart';
import 'dart:convert';

import '../utils/show_toast.dart';

class TaskProvider with ChangeNotifier {
  Task _currentTask = Task(id: '', content: '');
  bool _dataFetchedFromApi = false;

  Task get currentTask => _currentTask;

  List<Task> _toDo = [];
  List<Task> _inProgress = [];
  List<Task> _done = [];
  List<Task> _completed = [];

  List<Task> get toDo => _toDo;
  List<Task> get inProgress => _inProgress;
  List<Task> get done => _done;
  List<Task> get completed => _completed;

  TaskProvider() {
    _initializeTasks();
  }

  Future<void> _initializeTasks() async {
    await fetchTasks();
    await _fetchTasksFromPreferences();
  }

  void setCurrentTask(Task newTask) {
    _currentTask = newTask;
    notifyListeners();
  }

  void setTimer(int seconds) {
    _currentTask.timespent = seconds;
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    try {
      List<Task> tasks = await TasksService.fetchTasks();
      _currentTask = tasks.isNotEmpty ? tasks[0] : Task(id: '', content: '');

      _updateTasksList(tasks);
      await _fetchCompletedTasksFromPreferences();

      _dataFetchedFromApi =
          true; // Set flag to true when data is fetched from API
      notifyListeners();
    } catch (error) {
      log('Error fetching tasks from API: $error');
      if (!_dataFetchedFromApi) {
        await _fetchTasksFromPreferences();
      }
    }
  }

  void _updateTasksList(List<Task> tasks) {
    final newTasks = tasks.where((task) {
      final taskId = task.id;
      return !_toDo.any((t) => t.id == taskId) &&
          !_inProgress.any((t) => t.id == taskId) &&
          !_done.any((t) => t.id == taskId) &&
          !_completed.any((t) => t.id == taskId);
    }).toList();

    _toDo = [...toDo, ...newTasks];
    _saveTasksToPreferences();
  }

  Future<void> addTask(String content, String taskDescription) async {
    try {
      await TasksService.addTask(content, taskDescription);
      await fetchTasks();
    } catch (error) {
      log('Error adding task via API: $error');
      _toDo.add(Task(
          id: DateTime.now().toString(),
          content: content,
          description: taskDescription));
      _saveTasksToPreferences();
      notifyListeners();
    }
  }

  Future<void> deleteTask() async {
    try {
      await TasksService.deleteTask(_currentTask.id!);
      _removeTaskFromLists(_currentTask.id!);
      notifyListeners();
      await fetchTasks();
    } catch (error) {
      log('Error deleting task via API: $error');
      _removeTaskFromLists(_currentTask.id!);
      notifyListeners();
    }
  }

  void _removeTaskFromLists(String taskId) {
    _toDo.removeWhere((task) => task.id == taskId);
    _inProgress.removeWhere((task) => task.id == taskId);
    _done.removeWhere((task) => task.id == taskId);
    _saveTasksToPreferences();
  }

  Future<void> completeTask() async {
    try {
      var temp = _currentTask;
      _completed.add(temp);

      await _saveCompletedTasksToPreferences();

      _removeTaskFromLists(_currentTask.id!);

      await fetchTasks();

      notifyListeners();
      showToast('Task completed successfully');
    } catch (error) {
      log('Error completing task: $error');
      showToast('Error completing task');
    }
  }

  Future<void> editTask(
      String taskId, String newContent, String description) async {
    try {
      _currentTask.content = newContent;
      _currentTask.description = description;
      notifyListeners();
      await TasksService.editTask(taskId, newContent, description);
      await fetchTasks();
    } catch (error) {
      log('Error editing task via API: $error');
      _currentTask.content = newContent;
      _currentTask.description = description;
      _saveTasksToPreferences();
      notifyListeners();
    }
    showToast('Task edited successfully');
  }

  Future<void> _saveTasksToPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          'toDoTasks', _toDo.map((task) => jsonEncode(task.toJson())).toList());
      await prefs.setStringList('inProgressTasks',
          _inProgress.map((task) => jsonEncode(task.toJson())).toList());
      await prefs.setStringList(
          'doneTasks', _done.map((task) => jsonEncode(task.toJson())).toList());
      await prefs.setStringList('completedTasks',
          _completed.map((task) => jsonEncode(task.toJson())).toList());
      // _showToast('Tasks saved to local storage');
    } catch (error) {
      log('Error saving tasks: $error');
      showToast('Error saving tasks to local storage');
    }
  }

  Future<void> _fetchTasksFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? toDoTaskStrings = prefs.getStringList('toDoTasks');
      List<String>? inProgressTaskStrings =
          prefs.getStringList('inProgressTasks');
      List<String>? doneTaskStrings = prefs.getStringList('doneTasks');
      List<String>? completedTaskStrings =
          prefs.getStringList('completedTasks');

      if (toDoTaskStrings != null) {
        _toDo = toDoTaskStrings
            .map((taskString) => Task.fromJson(jsonDecode(taskString)))
            .toList();
      }
      if (inProgressTaskStrings != null) {
        _inProgress = inProgressTaskStrings
            .map((taskString) => Task.fromJson(jsonDecode(taskString)))
            .toList();
      }
      if (doneTaskStrings != null) {
        _done = doneTaskStrings
            .map((taskString) => Task.fromJson(jsonDecode(taskString)))
            .toList();
      }
      if (completedTaskStrings != null) {
        _completed = completedTaskStrings
            .map((taskString) => Task.fromJson(jsonDecode(taskString)))
            .toList();
      }
    } catch (error) {
      log('Error fetching tasks from preferences: $error');
    }
  }

  Future<void> _saveCompletedTasksToPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> completedTaskStrings =
          _completed.map((task) => jsonEncode(task.toJson())).toList();
      await prefs.setStringList('completedTasks', completedTaskStrings);
    } catch (error) {
      log('Error saving completed tasks: $error');
    }
  }

  Future<void> _fetchCompletedTasksFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? completedTaskStrings =
          prefs.getStringList('completedTasks');
      if (completedTaskStrings != null) {
        _completed.clear();
        for (String taskString in completedTaskStrings) {
          _completed.add(Task.fromJson(jsonDecode(taskString)));
        }
      }
    } catch (error) {
      log('Error fetching completed tasks from preferences: $error');
    }
  }
}
