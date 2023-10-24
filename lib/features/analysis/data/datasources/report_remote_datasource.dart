import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/shared/error_handler.dart';
import '../../../login/data/localdata/local_storage_data.dart';
import '../models/daily_report_model.dart';
import '../models/monthly_report_model.dart';
import '../models/weekly_report_model.dart';

abstract class ReportRemoteDataSource {
  Future<DailyReportModel> getDailyReport({required DateTime startDate});

  Future<WeeklyReportModel> getWeeklyReport({required DateTime endDate});

  Future<MonthlyReportModel> getMonthlyReport(
      {required int year, required int month});
}

class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  final http.Client client;
  final LocalStorage localStorage;
  final String baseUrl = 'https://food-dispenser-api.onrender.com/v1/report';

  ReportRemoteDataSourceImpl(
      {required this.client, required this.localStorage});

  @override
  Future<DailyReportModel> getDailyReport({required DateTime startDate}) async {
    try {
      final token = await localStorage.readFromStorage('Token');

      final response = await client.post(
        Uri.parse("${baseUrl}/daily"),
        body: {'startDate': startDate.toIso8601String()},
        headers: {
          "Authorization": "Bearer ${token.toString()}",
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        return DailyReportModel.fromJson(json.decode(response.body));
      } else {
        final errorMessage = ErrorHandler.handleError(response);
        throw Exception(errorMessage);
      }
    } catch (error) {
      final errorMessage = ErrorHandler.handleException(error);
      throw Exception(errorMessage);
    }
  }

  @override
  Future<WeeklyReportModel> getWeeklyReport({required DateTime endDate}) async {
    try {
      final token = await localStorage.readFromStorage('Token');
      print(token);
      final response = await client.post(
        Uri.parse("https://food-dispenser-api.onrender.com/v1/report/weekly"),
        body: {"endDate": endDate.toIso8601String()},
        headers: {
          "Authorization": "Bearer ${token.toString()}",
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        return WeeklyReportModel.fromJson(json.decode(response.body));
      } else {
        final errorMessage = ErrorHandler.handleError(response);
        throw Exception(errorMessage);
      }
    } catch (error) {
      final errorMessage = ErrorHandler.handleException(error);
      throw Exception(errorMessage);
    }
  }

  @override
  Future<MonthlyReportModel> getMonthlyReport(
      {required int year, required int month}) async {
    try {
      final token = await localStorage.readFromStorage('Token');
      print(year);
      print(month);
      print(token);

      final response = await client.post(
        Uri.parse("${baseUrl}/monthly"),
        body: {
          'year': year.toString(),
          'month': (month - 1).toString(),
        },
        headers: {
          "Authorization": "Bearer ${token.toString()}",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return MonthlyReportModel.fromJson(json.decode(response.body));
      } else {
        final errorMessage = ErrorHandler.handleError(response);
        throw Exception(errorMessage);
      }
    } catch (error) {
      final errorMessage = ErrorHandler.handleException(error);
      throw Exception(errorMessage);
    }
  }
}
