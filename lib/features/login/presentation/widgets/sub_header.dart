import 'package:flutter/material.dart';

import '../../../../core/shared/constants.dart';

class SubHeader extends StatelessWidget {
  final subHeaderText;

  const SubHeader({required this.subHeaderText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight(context) * 0.02),
      child: Text(
        subHeaderText,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }
}
