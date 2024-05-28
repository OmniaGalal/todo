import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/utilities/firebase.dart';

import '../../models/tasks.dart';

class ListProvider extends ChangeNotifier {



  List<Task> tasksList = [];
  DateTime chosenDate = DateTime.now();
  void readTaskFromFirestore() async {
    QuerySnapshot<Task> query = await firebaseUtils.getCollection().get();
    tasksList = query.docs.map((task) {
      return task.data();
    }).toList();

    ///filtering tasks according to chosendate
    tasksList = tasksList.where((element) {
      if (chosenDate.day == element.date?.day &&
          chosenDate.month == element.date?.month &&
          chosenDate.year == element.date?.year) {
        return true;
      }
      return false;
    }).toList();
   // print('Filtered tasks: ${tasksList}');
    /// sort tasks
    tasksList.sort((task1, task2) {

      return task2.date!.compareTo(task1.date!);

    });
    notifyListeners();
  }

  void changeDate(DateTime newSelectedDate) {
    chosenDate = newSelectedDate;
    //print(chosenDate.millisecondsSinceEpoch);

    readTaskFromFirestore();
    notifyListeners();
  }

  ///sorting data
}
