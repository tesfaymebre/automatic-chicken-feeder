import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
          alignment: Alignment.topRight,
          child: TextButton(
              onPressed: () {
                //  on pressed we go to homePage
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Container()));
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              child: const Text(
                'Skip ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 66, 82, 229)),
              ))),
    );
  }
}
