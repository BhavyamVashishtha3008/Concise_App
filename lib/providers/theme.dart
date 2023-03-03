import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeTheme with ChangeNotifier{
  bool theme=false;
  void changeTheme(){
      theme=!theme;
      SystemChrome.setSystemUIOverlayStyle(
          (SystemUiOverlayStyle(
            statusBarColor: theme?Color(0xff22252e):Color(0xff1d425d), // transparent status bar
          )));
      notifyListeners();
  }
  void saveBool()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme',theme);
  }

 void loadData()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
      theme=prefs.getBool('theme')!;
    notifyListeners();
  }

}
