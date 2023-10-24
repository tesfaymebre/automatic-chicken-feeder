import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          // todo Home Screen
          if (state is AuthenticationAuthenticated) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(''),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(LoggedOut());
                          },
                          child: const Text('Logout'))),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
