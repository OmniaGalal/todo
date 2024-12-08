import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/utilities/firebase.dart';
import 'package:todoapp/models/tasks.dart';
import 'package:todoapp/providers/list_provider/listProvider.dart';
import 'package:todoapp/ui/auth/home/bottomSheet.dart';
import 'package:todoapp/ui/auth/home/homeScreen.dart';
import 'package:todoapp/ui/auth/home/tasks.dart';

import '../../../providers/user_provider/userProvider.dart';

class EditScreen extends StatefulWidget {
  static String routeName = "Edit";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController editedTitle = TextEditingController();

  TextEditingController editedDesc = TextEditingController();

  DateTime select = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Task;

    var provider = Provider.of<ListProvider>(context);
    var userprovider=Provider.of<UserProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
        margin: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                initialValue: args.title,
                //controller: editedTitle,
                maxLines: 4,
                onChanged: (value) {
                  args.title = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                // controller: editedDesc,
                initialValue: args.description,
                onChanged: (value) {
                  args.description = value;
                },
                maxLines: 4,
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: () async{
                    var date = await
                    showDatePicker(
                        context: context,

                        //currentDate: task.date,
                        initialDate: args.date,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)));
                    select = date!;
                  },
                  child: Text("Edit date")),
              Spacer(),
              Center(child: Text(DateFormat("yyyy-MM-dd").format(select))),
              ElevatedButton(
                  onPressed: () {
                    firebaseUtils.updateTask(Task(
                        id: args.id,
                        title: args.title,
                        date: select,
                        description: args.description),userprovider.currentUser!.id!);
                    provider.readTaskFromFirestore(userprovider.currentUser!.id!);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  },
                  child: Text("Update")),
            ],
          ),
        ),
      ),
    );
  }
}
