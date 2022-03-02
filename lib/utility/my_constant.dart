import 'package:flutter/material.dart';

class MyConstant {
//field
  static String appName = 'Officer SV';

  static Color primary = const Color(0xffFF725E);
  static Color dark = const Color(0xffc64134);
  static Color ligh = const Color(0xffffa48c);

//method
BoxDecoration curBorder() => BoxDecoration(
          border: Border.all(color: MyConstant.dark),
          borderRadius: BorderRadius.circular(15));



BoxDecoration painBox() => BoxDecoration(
  color: ligh.withOpacity(0.5),
);


  TextStyle h1Style() => TextStyle(
        fontSize: 30,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

   
}
