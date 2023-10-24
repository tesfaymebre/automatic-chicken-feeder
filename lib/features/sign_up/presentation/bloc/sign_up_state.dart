part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final SignUpEntity signUpEntity;

  SignUpSuccess({required this.signUpEntity});

  @override
  List<Object> get props => [signUpEntity];
}

class SignUpFailure extends SignUpState {
  final String errorMessage;

  SignUpFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
