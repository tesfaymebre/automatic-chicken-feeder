import 'package:flutter/material.dart';

import '../../../../core/shared/colors.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: primary,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
