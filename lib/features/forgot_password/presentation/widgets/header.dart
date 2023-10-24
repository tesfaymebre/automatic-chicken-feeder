import 'package:flutter/material.dart';

import '../../../../core/shared/colors.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.labelText,
  }) : super(key: key);

  final String labelText;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
      child: Text(
        labelText,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.headline1?.copyWith(
              fontFamily: 'Poppins SemiBold',
              fontSize: screenSize.width * 0.048,
              color: grey_dark,
            ),
      ),
    );
  }
}
