import 'package:flutter/material.dart';
import 'package:todoapp/components/custom_text_form_field.dart';
import 'package:todoapp/ui/auth/home/homeScreen.dart';
import 'package:todoapp/ui/auth/login/loginScreen.dart';

class regisrerScreen extends StatelessWidget {
  static const String routeName = "register";
  regisrerScreen({Key? key}) : super(key: key);
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirm = TextEditingController();
  RegExp exp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
      caseSensitive: false);

  var formKey=GlobalKey<FormState>();
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
                      if(value!.trim().isEmpty||value==Null){
                        return "Name can't be empty";
                      }
                    },
                    text: "Full Name",
                    controller: controllerName,
                  ),

                  CustomTextFormField(
                    validation: (value) {
                      if(value==Null||value!.trim().isEmpty){
                        return "Email can't be empty";
                      }
                      if(!exp.hasMatch(value)){
                        return"Enter Valid Email";
                      }
                    },
                    text: "E-mail",
                    controller: controllerEmail,
                  ),

                  CustomTextFormField(
                    validation: (value) {
                      if(value==Null||value!.trim().isEmpty){
                        return "Password Can't be empty ";
                      }
                      if(value.length < 6){
                        return "Password Can't less then 6 digits ";
                      }
                      },
                    text: "Password",
                    controller: controllerPassword,
                  ),
                  CustomTextFormField(
                    validation: (value) {
                      if(value==Null||value!.trim().isEmpty){
                        return "Password Can't be empty ";
                      }
                      if(controllerPassword.text != value){
                        return "Password Not match";
                      }
                    },
                    text: "Confirm Password",
                    controller: controllerConfirm,
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        if(formKey.currentState!.validate()==false){
                          return;
                        }
                        Navigator.pushReplacementNamed(context, HomeScreen.routeName);

                      },
                      child: Text("Register",style: TextStyle(fontSize: 25),)),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, loginScreen.routeName);

                  }, child: Text("Already have an account ?  Log In"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
