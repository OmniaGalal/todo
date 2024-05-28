import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/tasks.dart';

class firebaseUtils {
  static CollectionReference<Task> getCollection() {
    return FirebaseFirestore.instance.collection("tasks").withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  static Future<void> addTaskToFireStore(Task task) {
    var collection = getCollection();
    DocumentReference<Task> docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> deleteTask(Task task) {
    return getCollection().doc(task.id).delete().timeout(
          Duration(milliseconds: 500),
          onTimeout: () => print('Task Deleted'),
        );
  }

  static Future<void> updateTask(Task task) async{
    try {
        await getCollection().doc(task.id).update(task.toFireStore());
        print('Task updated successfully');

    } catch (e) {
      print('Error updating task: $e');
      // Handle error
    }
  }
}
