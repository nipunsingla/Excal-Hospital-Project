import 'package:flutter/cupertino.dart';

class Loader{
  static bool isLoading=false;
  static void setLoading(){
    isLoading=!isLoading;
  }
}