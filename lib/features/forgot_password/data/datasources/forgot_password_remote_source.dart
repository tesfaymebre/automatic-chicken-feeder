import 'dart:convert';

import 'package:http/http.dart' as http;

class ForgotPasswordRemoteSource {
  final http.Client client;
  final String baseUrl =
      'https://food-dispenser-api.onrender.com/v1/feeding/capacity';

  ForgotPasswordRemoteSource({required this.client});

  Future<bool> sendEmailForVerificationCode({required String email}) async {
    const path = "/users/forgetPassword";
    var response = await client.post(
      Uri.parse("baseUrl${path}"),
      headers: {'Content-Type': 'application/json'},
      body: {
        "email": email,
      },
    );
    print(response);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Error_SENDING_EMAIL");
    }
  }

  Future<String> matchCodeEntered(
      {required String email, required String otpCode}) async {
    const path = "/users/validateOtp";
    var response = await client.post(
      Uri.parse("baseUrl${path}"),
      headers: {'Content-Type': 'application/json'},
      body: {
        "email": email,
        "otp": otpCode,
      },
    );
    if (response.statusCode == 200) {
      return otpCode;
    } else {
      throw Exception("Error_WHILE_SENDING_OTP");
    }
  }

  Future<void> updateForgottenPassword({
    required String otpCode,
    required String newPassword,
  }) async {
    const path = "/users/resetPassword";
    final response = await client.post(
      Uri.parse("baseUrl${path}"),
      headers: {'Content-Type': 'application/json'},
      body: {
        "otp": otpCode,
        "password": newPassword,
      },
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception("Error_WHILE_CHANGING_PASSWORD");
    }
  }
}
