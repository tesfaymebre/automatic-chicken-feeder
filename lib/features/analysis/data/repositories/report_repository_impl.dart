import 'dart:convert';

import 'package:chicken_feeder/features/home_page/domain/entities/all_feeding_data_entity.dart';
import 'package:chicken_feeder/core/error/failures.dart';
import 'package:chicken_feeder/features/home_page/domain/entities/feeding_schedule_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/daily_report_entity.dart';
import '../../domain/entities/monthlys_report_entity.dart';
import '../../domain/entities/weekly_report_entity.dart';
import '../../domain/repositories/report_repository.dart';
import '../datasources/report_remote_datasource.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDataSource reportRepositoryRemoteDataSource;

  ReportRepositoryImpl({required this.reportRepositoryRemoteDataSource});

  @override
  Future<DailyReportEntity> getDailyReport(
      {required DateTime startDate}) async {
    final dailyReport = await reportRepositoryRemoteDataSource.getDailyReport(
        startDate: startDate);

    return DailyReportEntity.fromModel(dailyReport);
  }

  @override
  Future<WeeklyReportEntity> getWeeklyReport(
      {required DateTime endDate}) async {
    final weeklyReport = await reportRepositoryRemoteDataSource.getWeeklyReport(
        endDate: endDate);

    return WeeklyReportEntity.fromModel(weeklyReport);
  }

  @override
  Future<MonthlyReportEntity> getMonthlyReport(
      {required int year, required int month}) async {
    final monthlyReport = await reportRepositoryRemoteDataSource
        .getMonthlyReport(year: year, month: month);

    return MonthlyReportEntity.fromModel(monthlyReport);
  }
}
