import '../datasources/forgot_password_remote_source.dart';

class ForgotPasswordRepository {
  final ForgotPasswordRemoteSource forgotPasswordremoteSource;

  ForgotPasswordRepository({required this.forgotPasswordremoteSource});

  Future<bool> sendEmailForVerificationCode({required String email}) async {
    return await forgotPasswordremoteSource.sendEmailForVerificationCode(
      email: email,
    );
  }

  Future<String> matchCodeEntered(
      {required String otpCode, required String email}) async {
    String message = await forgotPasswordremoteSource.matchCodeEntered(
      email: email,
      otpCode: otpCode,
    );
    return otpCode;
  }

  Future<void> updateForgottenPassword({
    required otpCode,
    required newPassword,
  }) async {
    return await forgotPasswordremoteSource.updateForgottenPassword(
      otpCode: otpCode,
      newPassword: newPassword,
    );
  }
}
