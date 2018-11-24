import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homekeeper/model/task.dart';
import 'package:homekeeper/repo/task/taskstore.dart';

class FireTaskStore implements TaskStore {
  @override
  Future<String> createTask(Task task) async{
    final ref = Firestore.instance.collection('task').document();
    await ref.setData(task.toMap()); 
    return ref.documentID;
  }

  @override
  void deleteTask(String taskID) {
    
  }

  @override
  Stream<List<Task>> getTasks() async* {
    final snapshotStream = Firestore.instance.collection('tasks').snapshots();
    await for(var snapshot in snapshotStream) {
      var templateSnapshots = snapshot.documents;
      var x = templateSnapshots.map((document) {
        return Task.fromSnapshot(document);
      }).toList();
      yield x;
    }
  }

  @override
  Future updateTask(Task updatedTask) async{
     await updatedTask.reference.updateData(updatedTask.toMap());
  }
}