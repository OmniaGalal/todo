import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/utilities/colors.dart';
import 'package:todoapp/core/utilities/firebase.dart';
import 'package:todoapp/providers/list_provider/listProvider.dart';
import 'package:todoapp/ui/auth/home/taskListTab.dart';

import '../../../models/tasks.dart';

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ListProvider>(context);
    if (provider.tasksList.isEmpty) {
      provider.readTaskFromFirestore();
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            child: EasyDateTimeLine(
              activeColor: AppColor.primary,
              initialDate: provider.chosenDate,

              onDateChange: (selectedDate) {
                provider.changeDate(selectedDate);

              },
              locale: "en",
              headerProps: EasyHeaderProps(showHeader: false),
            ),
          ),
          Expanded(
            child: provider.tasksList.isEmpty ? Center(child: Text("No Tasks Yet")):ListView.builder(
                itemCount: provider.tasksList.length,
                itemBuilder: (context, index) =>
                    TaskListTab(task: provider.tasksList[index])),
          ),
        ],
      ),
    );
  }


}
