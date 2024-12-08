import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class dialogUtils {
  static showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const AlertDialog(

          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 5,
              ),
              Text("Loading....")
            ],
          ),
        );
      },
    );
  }

  static hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static showMessage(
  { required BuildContext context, String? text, String? title, String? oK, Function()? onPressed}) {
    List<Widget> actions = [];

    showDialog(
      context: context,
      builder: (context) {
        if (oK != null) {
          actions.add(ElevatedButton(onPressed: (){
            Navigator.pop(context);
            onPressed?.call();
          }, child: Text(oK)));
        }
        return AlertDialog(
          content: Row(
            children: [Expanded(child: Text(text!))],
          ),
          title: Text(title??""),
          actions: actions,

        );
      },
    );
  }

  static void showToast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      fontSize: 20.0
  );
}
}
