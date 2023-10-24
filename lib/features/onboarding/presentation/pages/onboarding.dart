import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../widgets/skip_button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final GlobalKey<NavigatorState> navigator = GlobalKey();
  List nextButtons = [
    'assets/images/next_button_1.png',
    'assets/images/next_button_2.png',
    'assets/images/end_next_button.png'
  ];
  int pageNumber = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Container(
            child: IntroductionScreen(
          dotsDecorator: DotsDecorator(
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              size: Size(10, 7),
              activeSize: Size(27, 7),
              activeColor: Color.fromARGB(255, 66, 82, 229),
              color: Color.fromARGB(255, 66, 82, 229)),
          showBackButton: false,
          next: Image.asset(
            nextButtons[pageNumber],
            width: 50,
            height: 50,
          ),
          done: Image.asset(
            'assets/images/end_next_button.png',
            width: 50,
            height: 50,
          ),
          onDone: () {
            // BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Container()));
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (_) => LoginScreen()));
          },
          onChange: (index) {
            setState(() {
              pageNumber = index;
            });
          },
          pages: [
            PageViewModel(
              title: 'Welcome to Smart Chicken Feeder',
              body: 'Manage your Site from anywhere anytime',
              decoration: getPageDecoration(),
              image: Center(
                child: Container(
                    child: Image.asset(
                  'assets/images/onboarding_image.png',
                  width: 200,
                  height: 200,
                )),
              ),
            ),
            PageViewModel(
              title: 'Control your Site from the comfort of your Home',
              body: 'Manage your Site from anywhere anytime',
              decoration: getPageDecoration(),
              image: Image.asset(
                'assets/images/onboarding_image.png',
                width: 200,
                height: 200,
              ),
            ),
            PageViewModel(
              title: 'Control your Site from the comfort of your Home',
              body: 'Manage your Site from anywhere anytime',
              decoration: getPageDecoration(),
              image: Image.asset(
                'assets/images/onboarding_image.png',
                width: 200,
                height: 200,
              ),
            )
          ],
        )),
        const SkipButton()
      ]),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(
          letterSpacing: 1, color: Color.fromARGB(255, 167, 167, 167)),
    );
  }
}
