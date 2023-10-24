part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordEvent {
  const ForgotPasswordInitial();
}

class SubmitEmailEvent extends ForgotPasswordEvent {
  final String email;

  const SubmitEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class ResubmitEmailEvent extends ForgotPasswordEvent {
  final String email;

  const ResubmitEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class SubmitVerificationCodeEvent extends ForgotPasswordEvent {
  final String email;
  final String otpCode;

  const SubmitVerificationCodeEvent(
      {required this.email, required this.otpCode});
}

class SubmitNewPasswordEvent extends ForgotPasswordEvent {
  final String otpCode;
  final String newPassword;

  const SubmitNewPasswordEvent(
      {required this.otpCode, required this.newPassword});
}

class ResetForgotPasswordState extends ForgotPasswordEvent {}
