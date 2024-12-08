import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/tasks.dart';
import 'package:todoapp/models/users.dart';

class firebaseUtils {
  static CollectionReference<Task> getCollection(String uID) {
    return getUsersCollection().doc(uID).collection("tasks").withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  static Future<void> addTaskToFireStore(Task task,String uID) {
    var collection = getCollection(uID);
    DocumentReference<Task> docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> deleteTask(Task task,String uID) {
    return getCollection(uID).doc(task.id).delete().then(
          (value) => print('Task Deleted'),
        );
  }

  static Future<void> updateTask(Task task,String uID) async {
    try {
      await getCollection(uID).doc(task.id).update(task.toFireStore());
      print('Task updated successfully');
    } catch (e) {
      print('Error updating task: $e');
      // Handle error
    }
  }



  static CollectionReference<Users> getUsersCollection(){
    return  FirebaseFirestore.instance
      .collection("users")
      .withConverter<Users>(
    fromFirestore: (snapshot, options) =>
        Users.fromFireStore(snapshot.data()!),
    toFirestore: (value, options) => value.toFireStore(),
  );
}

  static Future<void>addUsersToFireStore(Users newUser){
     return getUsersCollection().doc(newUser.id).set(newUser);
  }

  static Future<Users?> readUsersFromFireStore(String uID)async{
    var docRef= await getUsersCollection().doc(uID).get();
   return docRef.data();
  }
}
