import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/utilities/colors.dart';
import 'package:todoapp/core/utilities/firebase.dart';
import 'package:todoapp/ui/auth/home/bottomSheet.dart';
import 'package:todoapp/ui/auth/home/settings.dart';
import 'package:todoapp/ui/auth/home/tasks.dart';
import 'package:todoapp/ui/auth/login/loginScreen.dart';

import '../../../models/tasks.dart';
import '../../../providers/list_provider/listProvider.dart';
import '../../../providers/user_provider/userProvider.dart';

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
    var provider = Provider.of<UserProvider>(context, listen: false);
    var Listprovider = Provider.of<ListProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: AppColor.backGround,
        appBar: AppBar(
          title: Text(
            "To Do List ${{provider.currentUser!.Name!}}",
            style: TextStyle(fontFamily: "Poppins"),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Listprovider.tasksList=[];
                  provider.currentUser=null;
                  Navigator.pushReplacementNamed(
                      context,
                      loginScreen.routeName);
                },
                icon: Icon(Icons.logout))
          ],
          toolbarHeight:MediaQuery.of(context).size.height * .20,
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
