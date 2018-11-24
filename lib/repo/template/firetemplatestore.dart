import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homekeeper/model/template.dart';
import 'package:homekeeper/repo/template/templatestore.dart';

class FireTemplateStore implements TemplateStore {
  @override
  Future<String> createTemplate(Template template) async{
    final ref = Firestore.instance.collection('template').document();
    await ref.setData(template.toMap()); 
    return ref.documentID;
  }

  @override
  void deleteTemplate(String templateID) {
    
  }

  @override
  Stream<List<Template>> getTemplates() async* {
    final snapshotStream = Firestore.instance.collection('template').snapshots();
    await for(var snapshot in snapshotStream) {
      var templateSnapshots = snapshot.documents;
      var x = templateSnapshots.map((document) {
        return Template.fromSnapshot(document);
      }).toList();
      yield x;
    }
  }

  @override
  Future updateTemplate(Template updatedTemplate) async{
     await updatedTemplate.reference.updateData(updatedTemplate.toMap());
  }
}