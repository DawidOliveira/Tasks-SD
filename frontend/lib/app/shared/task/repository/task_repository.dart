import 'package:dio/dio.dart';
import 'package:frontend/app/shared/task/repository/task_repository_interface.dart';

class TaskRepository implements ITaskRepository {
  final String _url = "http://localhost:3000";

  @override
  createTask(String desc) async {
    final Response response = await Dio().post('$_url/task', data: {
      "desc": desc,
    });

    return response;
  }

  @override
  deleteTask(int id) async {
    final Response response = await Dio().delete('$_url/task/$id');

    return response;
  }

  @override
  getTasks() async {
    try {
      final Response response = await Dio().get('$_url/tasks');
      return response;
    } on DioError catch (err) {
      print(err);
    }
  }

  @override
  updateTask(int id) async {
    final Response response = await Dio().put('$_url/task/$id');

    return response;
  }
}
