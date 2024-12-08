import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/utilities/firebase.dart';
import 'package:todoapp/ui/auth/home/editScreen.dart';

import '../../../core/utilities/colors.dart';
import '../../../models/tasks.dart';
import '../../../providers/list_provider/listProvider.dart';
import '../../../providers/user_provider/userProvider.dart';

class TaskListTab extends StatefulWidget {
  TaskListTab({required this.task});
  Task task;

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ListProvider>(context);
    var userprovider=Provider.of<UserProvider>(context,listen: false);

    return Column(
      children: [
        Slidable(
          startActionPane: ActionPane(
            motion: ScrollMotion(),
            extentRatio: .5,
            children: [
              SlidableAction(
                onPressed: (context) {
                  firebaseUtils.deleteTask(widget.task,userprovider.currentUser!.id!);
                  provider.readTaskFromFirestore(userprovider.currentUser!.id!);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: (context) {
                  Navigator.pushNamed(context, EditScreen.routeName,
                      arguments: widget.task);
                },
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
                label: 'Edit',
              ),
            ],
          ),
          child: Card(
              // margin: EdgeInsets.all(8),
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .096,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.task.title ?? "unknown",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 20, color: AppColor.primary),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.height * .35,
                            child: Text(
                              widget.task.description ?? "unknown",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                          Text(
                              "${DateFormat("yyyy-MM-dd").format(widget.task.date!) ?? "unknown"} "),
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    InkWell(
                      onTap: () {
                        firebaseUtils.updateTask(Task(
                            title: widget.task.title,
                            date: widget.task.date,
                            description: widget.task.description,
                            id: widget.task.id,
                            isDone: true),userprovider.currentUser!.id!);
                        provider.readTaskFromFirestore(userprovider.currentUser!.id!);
                      },
                      child: widget.task.isDone == true
                          ? Text(
                              "Done",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.green),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * .02,
                                  vertical: 2),
                              decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                    )
                    // ElevatedButton(onPressed: (){}, child: Icon(Icons.check))
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
