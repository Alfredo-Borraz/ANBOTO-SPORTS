import 'package:flutter/material.dart';

InputDecoration appStyle(hintText){
  return InputDecoration(
    hintText: hintText,
    fillColor: Colors.transparent,
    filled: true,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(10.0)//phone,
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1.3,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
  );
}

abstract class AppStyle {
  static const TextStyle styleSemibold20 = TextStyle(
    color: Color(0xffFFDE69),
    fontFamily: "SegoeUI",
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle styleRegular18 = TextStyle(
    color: Color(0xffFFDE69),
    fontFamily: "SegoeUI",
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle styleLight20 = TextStyle(
    color: Color(0xffF4F4F4),
    fontFamily: "SegoeUI",
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle styleRegular36 = TextStyle(
    color: Color(0xffEF5858),
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle styleRegular11 = TextStyle(
    color: Color(0xffFFDE69),
    fontFamily: "SegoeUI",
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle styleRegular20 = TextStyle(
    color: Color(0xff050522),
    fontFamily: "SegoeUI",
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle styleBold30 = TextStyle(
    color: Color(0xff050522),
    fontFamily: "SegoeUI",
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle styleRegular15 = TextStyle(
    color: Color(0xff000000),
    fontFamily: "SegoeUI",
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle styleRegular12 = TextStyle(
    color: Color(0xff050522),
    fontFamily: "SegoeUI",
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font14GrayRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color.fromARGB(255, 0, 0, 0),
  );
}


