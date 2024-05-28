import 'package:flutter/material.dart';
import 'package:todoapp/core/utilities/colors.dart';
import 'package:todoapp/core/utilities/firebase.dart';
import 'package:todoapp/ui/auth/home/bottomSheet.dart';
import 'package:todoapp/ui/auth/home/settings.dart';
import 'package:todoapp/ui/auth/home/tasks.dart';

import '../../../models/tasks.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndx = 0;
  var tabs = [TasksScreen(), SettingsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backGround,
        appBar: AppBar(
          title: Text(
            "To Do List",
            style: TextStyle(fontFamily: "Poppins"),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * .20,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 35,
          ),
          shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AddBottomSheet(),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: currentIndx,
            onTap: (index) {
              print(index);
              setState(() {
                currentIndx = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 20,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 20,
                  ),
                  label: ""),
            ],
          ),
        ),
        body: tabs[currentIndx]);
  }
}
