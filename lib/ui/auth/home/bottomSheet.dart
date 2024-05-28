import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/custom_text_form_field.dart';
import 'package:todoapp/core/utilities/colors.dart';
import 'package:todoapp/core/utilities/firebase.dart';
import 'package:todoapp/models/tasks.dart';
import 'package:todoapp/ui/auth/home/taskListTab.dart';
import 'package:todoapp/ui/auth/home/tasks.dart';

import '../../../providers/list_provider/listProvider.dart';

class AddBottomSheet extends StatefulWidget {
  AddBottomSheet({Key? key}) : super(key: key);


  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var seletedDate = DateTime.now();

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Text(
            "Add new Task",
            style: Theme.of(context).textTheme.titleLarge,
          )),
          Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    validation: (value) {
                      if (value == Null || value!.trim().isEmpty) {
                        return "Can't be empty";
                      }
                    },
                    controller: title,
                    text: "enter your task",
                    lines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    validation: (value) {
                      if (value == Null || value!.trim().isEmpty) {
                        return "Can't be empty";
                      }
                    },
                    controller:desc,
                    text: "enter your task description",
                    lines: 4,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Select Date",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          InkWell(
            onTap: () {
              showDate();
            },
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${seletedDate.day}/${seletedDate.month}/${seletedDate.year} ",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 16),
                ),
                Text(
                  "${ seletedDate.hour}  -  ${seletedDate.minute}} ",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 16,color: Colors.transparent),
                ),



              ],
            )),
          ),
          SizedBox(height: 8),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate() == true) {
                  Task task = Task(
                      title: title.text,
                      date: seletedDate,
                      description: desc.text);
                  firebaseUtils.addTaskToFireStore(task).timeout(
                        Duration(milliseconds: 500),
                        onTimeout: () => print('added successfully'),
                        // print(task.date),
                      );

                  provider.readTaskFromFirestore();

                  Navigator.pop(context);
                }
              },
              child: Text("Add"))
        ],
      ),
    );
  }

  void showDate() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    setState(() {
      if (date != null) {
        seletedDate = date;
      } else {
        print('Nullll');
      }
    });
  }
}
