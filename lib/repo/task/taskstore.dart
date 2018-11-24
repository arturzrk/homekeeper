import 'package:homekeeper/model/task.dart';

abstract class TaskStore {
  Stream<List<Task>> getTasks();
  Future<String> createTask(Task task);
  Future updateTask(Task updatedTask);
  void deleteTask(String taskID);
}