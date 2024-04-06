import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {required this.validation,this.lines, required this.text, this.controller});
  String text;
  int? lines;
  TextEditingController? controller;
  String? Function(String?)? validation;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: lines,
      controller: controller,
      validator: validation,
      decoration: InputDecoration(
        hintText: text,
      ),
    );
  }
}
