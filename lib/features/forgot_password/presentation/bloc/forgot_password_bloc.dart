import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/forgot_password_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordRepository forgotPasswordRepository;

  ForgotPasswordBloc({required this.forgotPasswordRepository})
      : super(InitialState()) {
    on<ForgotPasswordInitial>(_onForgotPasswordInitial);
    on<SubmitEmailEvent>(_onSubmitEmailEvent);
    on<SubmitVerificationCodeEvent>(_onSubmitVerificationCodeEvent);
    on<SubmitNewPasswordEvent>(_onSubmitNewPasswordEvent);
    on<ResubmitEmailEvent>(_onResubmitEmailEvent);
  }

  void _onForgotPasswordInitial(
      ForgotPasswordInitial event, Emitter<ForgotPasswordState> emit) {
    emit(InitialState());
  }

  void _onSubmitEmailEvent(
      SubmitEmailEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(LoadingState());
    final email = event.email;
    try {
      await forgotPasswordRepository.sendEmailForVerificationCode(email: email);
      emit(EmailSentState(email: email));
    } catch (e) {
      emit(EmailNotSentState());
    }
  }

  void _onSubmitVerificationCodeEvent(SubmitVerificationCodeEvent event,
      Emitter<ForgotPasswordState> emit) async {
    emit(LoadingState());
    try {
      String otpCode = await forgotPasswordRepository.matchCodeEntered(
          otpCode: event.otpCode, email: event.email);
      emit(CodeVerifiedState(otpCode: otpCode));
    } catch (e) {
      emit(IncorrectCodeSentState());
    }
  }

  void _onSubmitNewPasswordEvent(
      SubmitNewPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(LoadingState());
    try {
      await forgotPasswordRepository.updateForgottenPassword(
          otpCode: event.otpCode, newPassword: event.newPassword);
      emit(SuccessfullyChangedPasswordState());
    } catch (e) {
      emit(UpdateForgottenPasswordErrorState());
    }
  }

  void _onResubmitEmailEvent(
      ResubmitEmailEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(LoadingState());
    final email = event.email;
    try {
      await forgotPasswordRepository.sendEmailForVerificationCode(email: email);
      emit(EmailResendSuccessfulState(email: email));
    } catch (e) {
      emit(EmailNotSentState());
    }
  }
}
