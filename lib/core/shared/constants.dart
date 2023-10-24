import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

double screenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width / 428;
double screenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height / 926;
double fullScreenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;
double fullScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

String kgetCurrDate() {
  String currDate = DateFormat('E, d MMM yyyy').format(DateTime.now());
  return currDate;
}
testimonialTextFieldDecoration(BuildContext context) => InputDecoration(
      filled: true,
      fillColor: Color(0xFFF7F8F8),
      hintText: 'Enter a value',
      hintStyle: const TextStyle(
          fontFamily: 'Poppins', fontSize: 14, color: Color(0xFF5C5354)),
      contentPadding: EdgeInsets.only(
        top: screenHeight(context) * 15.63,
        bottom: screenHeight(context) * 16.38,
        left: screenWidth(context) * 16.5,
      ),
      border: InputBorder.none,
      
    );

kTextFieldDecoration(BuildContext context) => InputDecoration(
      filled: true,
      fillColor: Color(0xFFF7F8F8),
      hintText: 'Enter a value',
      hintStyle: const TextStyle(
          fontFamily: 'Poppins', fontSize: 15, color: Color(0xFF5C5354)),
      contentPadding: EdgeInsets.only(
        top: screenHeight(context) * 15.63,
        bottom: screenHeight(context) * 16.38,
        left: screenWidth(context) * 16.5,
      ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(screenHeight(context) * 14)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffF7F8F8), width: 1.0),
        borderRadius:
            BorderRadius.all(Radius.circular(screenHeight(context) * 5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffF7F8F8), width: 2.0),
        borderRadius:
            BorderRadius.all(Radius.circular(screenHeight(context) * 14)),
      ),
    );
