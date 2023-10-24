import 'package:flutter/material.dart';

import '../../../login/presentation/pages/login_screen.dart';

Widget buildTaptoLogin(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 40, left: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
        ),
        const SizedBox(
          width: 8,
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text(
              "Log in",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ))
      ],
    ),
  );
}
