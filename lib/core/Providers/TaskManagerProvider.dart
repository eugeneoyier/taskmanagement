import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class TaskManagerController extends GetxController {
  var tasks = List<Map<String, dynamic>>.empty().obs;
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://maids.pharmchem.co.ke/todo',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final response = await dio.post(
        '/manage_tasks.php',
        data: json.encode({'action': 'fetch', 'user_id': '1'}),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['tasks'] is List) {
          tasks.value = List<Map<String, dynamic>>.from(response.data['tasks']);
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Failed to load tasks');
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> addTask(String task) async {
    try {
      final response = await dio.post(
        '/manage_tasks.php',
        data: json.encode({'action': 'add', 'task': task, 'user_id': 1}),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        fetchTasks();
      } else {
        throw Exception('Failed to add task');
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      final response = await dio.post(
        '/manage_tasks.php',
        data: json.encode({'action': 'delete', 'task_id': id, 'user_id': 1}),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        fetchTasks();
      } else {
        throw Exception('Failed to delete task');
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> editTask(int id, String newTask) async {
    try {
      final response = await dio.post(
        '/manage_tasks.php',
        data: json.encode({
          'action': 'edit',
          'task_id': id,
          'new_task': newTask,
          'user_id': 1
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        fetchTasks();
      } else {
        throw Exception('Failed to edit task');
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
