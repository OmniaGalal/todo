import 'package:cloud_firestore/cloud_firestore.dart';
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

}
