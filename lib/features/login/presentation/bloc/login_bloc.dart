import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../user/data/model/user_model.dart';
import '../../data/models/email.dart';
import '../../data/models/password.dart';
import '../../domain/usecases/login.dart';
import 'auth/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authBloc;
  LoginBloc({
    required this.authBloc,
    required Login signInWithEmail,
  })  : _signInWithEmail = signInWithEmail,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LogOut>(_OnLogout);
  }
  final Login _signInWithEmail;
  void _OnLogout(
    LogOut event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        password: null,
        email: null,
        status: Formz.validate([]),
      ),
    );
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> memit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([state.password, email]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.email]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final response = await _signInWithEmail.call(Params(
        email: state.email.value,
        password: state.password.value,
      ));
      if (response.isLeft()) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      } else {
        authBloc.add(LoggedIn(
            user: response.getOrElse(() => UserModel()),
            token: response.toOption().toNullable()!.token!));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
