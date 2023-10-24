import 'package:flutter/material.dart';

import '../../../../core/shared/constants.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Image sideImage;
  final String title;
  final VoidCallback onPressed;

  const RoundedButton(
      {required this.color,
      required this.sideImage,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: screenWidth(context) * 15),
      child: Material(
        color: color,
        borderRadius:
            BorderRadius.all(Radius.circular(screenHeight(context) * 10)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: screenWidth(context) * 323,
          height: screenHeight(context) * 49,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth(context) * 30,
                    top: screenHeight(context) * 10,
                    right: screenWidth(context) * 20,
                    bottom: screenHeight(context) * 10),
                child: sideImage,
              ),
              SizedBox(
                width: screenWidth(context) * 12,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: "SF Pro Text Regular",
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
