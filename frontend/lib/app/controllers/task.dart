import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/shared/task/repository/task_repository.dart';

class TaskController with ChangeNotifier {
  TaskRepository _taskRepository = TaskRepository();

  createTask(String desc) async {
    await _taskRepository.createTask(desc);
    notifyListeners();
  }

  updateTask(int id) async {
    await _taskRepository.updateTask(id);
    notifyListeners();
  }

  deleteTask(int id) async {
    await _taskRepository.deleteTask(id);
    notifyListeners();
  }

  Future<List> getTasks() async {
    final Response response = await _taskRepository.getTasks();
    // List<TaskModel> listTasks = (response.data as List)
    //     .map((task) =>
    //         TaskModel(desc: task["desc"], id: task["id"], done: task["done"]))
    //     .toList();
    return response.data;
  }
}
