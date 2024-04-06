import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/utilities/colors.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/ui/auth/register/registerScreen.dart';

import 'ui/auth/home/homeScreen.dart';
import 'ui/auth/login/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppColor.light,
      debugShowCheckedModeBanner: false,
      routes: {
        regisrerScreen.routeName: (context) => regisrerScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        loginScreen.routeName: (context) => loginScreen(),
      },
      initialRoute: HomeScreen.routeName,
      home: HomeScreen(),
    );
  }
}
