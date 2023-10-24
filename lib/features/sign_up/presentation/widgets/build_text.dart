import 'package:flutter/material.dart';

Widget buildText({required String name}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15, left: 10),
    child: Text(
      name,
    ),
  );
}
