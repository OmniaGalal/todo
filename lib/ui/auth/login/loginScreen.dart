import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/custom_text_form_field.dart';
import 'package:todoapp/core/utilities/dialog.dart';
import 'package:todoapp/core/utilities/firebase.dart';
import 'package:todoapp/ui/auth/home/homeScreen.dart';
import 'package:todoapp/ui/auth/register/registerScreen.dart';

import '../../../providers/user_provider/userProvider.dart';
import '../home/homeScreen.dart';

class loginScreen extends StatefulWidget {
  static const String routeName = "login";
  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController controllerEmail = TextEditingController();

  TextEditingController controllerPassword = TextEditingController();

  RegExp exp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
      caseSensitive: false);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    validation: (value) {
                      if (value == Null || value!.trim().isEmpty) {
                        return "Email can't be empty";
                      }
                      if (!exp.hasMatch(value)) {
                        return "Enter Valid Email";
                      }
                    },
                    text: "E-mail",
                    controller: controllerEmail,
                  ),
                  CustomTextFormField(
                    validation: (value) {
                      if (value == Null || value!.trim().isEmpty) {
                        return "Password Can't be empty ";
                      }
                      if (value.length < 6) {
                        return "Password Can't less then 6 digits ";
                      }
                    },
                    text: "Password",
                    controller: controllerPassword,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        if (formKey.currentState!.validate() == false) {
                          return;
                        }
                       signIn();
                      },
                      child: Text(
                        "Log In ",
                        style: TextStyle(fontSize: 25),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, regisrerScreen.routeName);
                      },
                      child: Text("Not have account ? Register"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    dialogUtils.showLoading(context);

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controllerEmail.text, password: controllerPassword.text);

    var user= await firebaseUtils.readUsersFromFireStore(credential.user?.uid??"");
      if(user==null){
        return;

      }
      var provider=Provider.of<UserProvider>(context,listen: false);
      provider.updateUser(user);

      dialogUtils.hideLoading(context);
      dialogUtils.showToast("Signed in successfully");
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      print(credential.user?.uid??"");
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      if (e.code == 'invalid-credential') {
        dialogUtils.hideLoading(context);
        dialogUtils.showMessage(
          context: context,
          text: "No user found ",
        );
        print('No user found for that email.');
      }

      // else if (e.code == 'wrong-password') {
      //   dialogUtils.hideLoading(context);
      //   dialogUtils.showMessage(
      //     context: context,
      //     text: "Wrong password provided for that user.",
      //   );
      //   print('Wrong password provided for that user.');
      // }
    }
  }
}
