
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Themes {
  static final light = ThemeData(
    timePickerTheme: TimePickerThemeData(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF5C85C1).withOpacity(0.8),
    backgroundColor: Colors.white,
  );

  static final dark = ThemeData(
    timePickerTheme: TimePickerThemeData(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF5C85C1).withOpacity(0.8),
    backgroundColor: const Color(0xFF121212),
  );
}
class MyTheme {
  static final light = ThemeData(
    timePickerTheme: TimePickerThemeData(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF5C85C1).withOpacity(0.8),
    backgroundColor: Colors.white,
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF5C85C1).withOpacity(0.8),
    scaffoldBackgroundColor: const Color(0xFF121212),
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode?Colors.grey[100]:Colors.grey[600]
    )
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle:TextStyle(
        color: Get.isDarkMode?Colors.white:Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.bold
    )
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle:TextStyle(
        color: Get.isDarkMode?Colors.white:Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400
    )
  );
}
