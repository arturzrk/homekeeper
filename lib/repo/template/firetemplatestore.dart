import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homekeeper/model/template.dart';
import 'package:homekeeper/repo/template/templatestore.dart';
import 'package:meta/meta.dart';

class FireTemplateStore implements TemplateStore {
  final String accountName;

  FireTemplateStore({@required this.accountName}) : assert(accountName != null);

  @override
  Future<String> createTemplate(Template template) async {
    final ref = Firestore.instance.collection(getCollectionPath()).document();
    await ref.setData(template.toMap());
    return ref.documentID;
  }

  @override
  Future deleteTemplate(Template  templateToDelete) async {
    //return templateToDelete.reference.delete();
  }

  @override
  Stream<List<Template>> getTemplates() async* {
    final snapshotStream =
        Firestore.instance.collection(getCollectionPath()).snapshots();
    await for (var snapshot in snapshotStream) {
      var templateSnapshots = snapshot.documents;
      var x = templateSnapshots.map((document) {
        return Template.fromSnapshot(document);
      }).toList();
      yield x;
    }
  }

  @override
  Future updateTemplate(Template updatedTemplate) async {
    //await updatedTemplate.reference.updateData(updatedTemplate.toMap());
  }

  String getCollectionPath() => 'users/$accountName/template';
}
