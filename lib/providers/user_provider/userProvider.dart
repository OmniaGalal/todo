import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapp/models/users.dart';

class UserProvider extends ChangeNotifier{
  Users? currentUser;

  void updateUser(Users newUser){
    currentUser=newUser;
    notifyListeners();
  }
}