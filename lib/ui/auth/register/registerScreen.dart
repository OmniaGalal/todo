import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/custom_text_form_field.dart';
import 'package:todoapp/core/utilities/dialog.dart';
import 'package:todoapp/core/utilities/firebase.dart';
import 'package:todoapp/models/users.dart';
import 'package:todoapp/ui/auth/login/loginScreen.dart';

import '../../../providers/user_provider/userProvider.dart';
import '../home/homeScreen.dart';

class regisrerScreen extends StatefulWidget {
  static const String routeName = "register";
  regisrerScreen({Key? key}) : super(key: key);

  @override
  State<regisrerScreen> createState() => _regisrerScreenState();
}

class _regisrerScreenState extends State<regisrerScreen> {
  TextEditingController controllerName = TextEditingController(text: "Omnia");

  TextEditingController controllerEmail =
      TextEditingController(text: "Omnia@gmail.com");

  TextEditingController controllerPassword =
      TextEditingController(text: "123456");

  TextEditingController controllerConfirm =
      TextEditingController(text: "123456");

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
                      if (value!.trim().isEmpty || value == Null) {
                        return "Name can't be empty";
                      }
                    },
                    text: "Full Name",
                    controller: controllerName,
                  ),
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
                  CustomTextFormField(
                    validation: (value) {
                      if (value == Null || value!.trim().isEmpty) {
                        return "Password Can't be empty ";
                      }
                      if (controllerPassword.text != value) {
                        return "Password Not match";
                      }
                    },
                    text: "Confirm Password",
                    controller: controllerConfirm,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () async {
                        if (formKey.currentState!.validate() == true) {
                          await createNewUser();

                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 25),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, loginScreen.routeName);
                      },
                      child: Text("Already have an account ?  Log In"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential?> createNewUser() async {
    dialogUtils.showLoading(context);

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
      var provider=Provider.of<UserProvider>(context,listen: false);
      provider.updateUser(Users(id: credential.user?.uid??"", Name: controllerName.text, Email: controllerEmail.text));
      await  firebaseUtils.addUsersToFireStore(Users(
          id: credential.user?.uid??"",
          Name: controllerName.text,
          Email: controllerEmail.text));
      dialogUtils.hideLoading(context);
      dialogUtils.showToast("Register Successfully");


      // dialogUtils.showMessage(
      //     context: context, text: "Register Successfully", OK: "Ok");
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      print(credential.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        dialogUtils.hideLoading(context);
        dialogUtils.showMessage(
            context: context,
            text: "The password provided is too weak.",
            oK: "Ok");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        dialogUtils.hideLoading(context);
        dialogUtils.showMessage(
            context: context,
            text: "The account already exists for that email.",
            oK: "Ok");
        print('The account already exists for that email.');
      }
    } catch (e) {
      dialogUtils.showMessage(context: context,text: e.toString());
      print(e);
    }
  }
}
