

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class flutterToast

{


  void toastMessage(String message)


  {

    Fluttertoast.showToast(msg: message,

    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.black,
      fontSize: 13.0,




    );






  }







}