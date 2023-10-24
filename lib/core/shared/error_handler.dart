import 'dart:convert';

import 'package:http/http.dart' as http;

class ErrorHandler {
  static String handleError(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body);

    if (responseBody.containsKey('message')) {
      return responseBody['message'];
    }

    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your request parameters.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden. You do not have permission to access this resource.';
      case 404:
        return 'Not found. The requested resource was not found.';
      case 500:
        return 'Internal server error. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  static String handleException(dynamic error) {
    if (error is http.ClientException) {
      return 'Network error. Please check your internet connection.';
    } else {
      return 'An error occurred. Please try again.';
    }
  }
}
