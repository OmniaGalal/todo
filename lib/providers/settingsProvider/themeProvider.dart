import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode theme = ThemeMode.dark;

  changeTheme(ThemeMode Newtheme) {
    theme = Newtheme;
    notifyListeners();
  }

  bool isDrak(){
  return theme==ThemeMode.light;
  }
}
