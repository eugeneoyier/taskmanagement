import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/core/Providers/TaskManagerProvider.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TaskManagerController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.tasks[index];
            return ListTile(
              title: Text(task['task']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () =>
                        _showEditDialog(context, task['id'], task['task']),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => controller.deleteTask(task['id']),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: controller,
            onSubmitted: (value) {
              Get.find<TaskManagerController>().addTask(value);
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                Get.find<TaskManagerController>().addTask(controller.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, int id, String taskText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController controller =
            TextEditingController(text: taskText);
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: controller,
            onSubmitted: (newText) {
              Get.find<TaskManagerController>().editTask(id, newText);
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                Get.find<TaskManagerController>().editTask(id, controller.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
