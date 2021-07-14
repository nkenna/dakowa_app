import 'package:flutter/material.dart';

Color mainColor = Color(0xff0b6375); // primary buttons


Map<int, Color> cColor = {
  50: Color.fromRGBO(11, 99, 117, .1),
  100: Color.fromRGBO(11, 99, 117, .2),
  200: Color.fromRGBO(11, 99, 117,.3),
  300: Color.fromRGBO(11, 99, 117, .4),
  400: Color.fromRGBO(11, 99, 117, .5),
  500: Color.fromRGBO(11, 99, 117, .6),
  600: Color.fromRGBO(11, 99, 117, .7),
  700: Color.fromRGBO(11, 99, 117, .8),
  800: Color.fromRGBO(11, 99, 117, .9),
  900: Color.fromRGBO(11, 99, 117, 1),
};

MaterialColor materialMainColor = MaterialColor(
    0xff0b6375,
    cColor);