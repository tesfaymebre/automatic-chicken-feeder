import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({
    Key? key,
    required this.form,
  }) : super(key: key);

  final Widget form;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: form,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
    );
  }
}
