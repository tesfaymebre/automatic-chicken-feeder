part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus {
  initial, // waiting for email entry
  loading,
  emailSent, // waiting for code entry
  codeVerified, // waiting for new password entry
  codeIncorrect,

  successfullyChangedPassword,
}

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class InitialState extends ForgotPasswordState {}

class LoadingState extends ForgotPasswordState {}

class EmailSentState extends ForgotPasswordState {
  final String email;

  const EmailSentState({required this.email});
  @override
  List<Object> get props => [email];
}

class EmailResendSuccessfulState extends ForgotPasswordState {
  final String email;

  const EmailResendSuccessfulState({required this.email});
  @override
  List<Object> get props => [email];
}

class EmailNotSentState extends ForgotPasswordState {}

class CodeVerifiedState extends ForgotPasswordState {
  final String otpCode;
  const CodeVerifiedState({required this.otpCode});
  @override
  List<Object> get props => [otpCode];
}

class IncorrectCodeSentState extends ForgotPasswordState {}

class SuccessfullyChangedPasswordState extends ForgotPasswordState {}

class UpdateForgottenPasswordErrorState extends ForgotPasswordState {}
