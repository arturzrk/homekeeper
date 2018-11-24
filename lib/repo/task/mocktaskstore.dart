import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/task.dart';
import 'package:homekeeper/repo/task/taskstore.dart';

class MockTaskStore implements TaskStore {

  final Duration _interval = Duration(milliseconds: 200);
  final _tasks =  [
    Task(
      title: 'first',
      category: TemplateCategory.hydrofor.name,
      startDate: DateTime.now(),
    ),
    Task(
      title: 'second',
      category: TemplateCategory.rekuperator.name,
      startDate: DateTime.now().add(Duration(days: 20)),
    ),
    Task(
      title: 'third',
      category: TemplateCategory.scieki.name,
      startDate: DateTime.now().add(Duration(days: 30)),
    )
  ];

  @override
  Future<String> createTask(Task task) async{
    _tasks.add(task);
    return "1234";
  }

  @override
  void deleteTask(String taskID) {
    return;
  }

  @override
  Stream<List<Task>> getTasks() async* {
    yield _tasks;
  }

  @override
  Future updateTask(Task updatedEvent) async{
    await Future.delayed(_interval);
  }
}