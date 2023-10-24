import 'package:chicken_feeder/features/home_page/domain/entities/feeding_schedule_entity.dart';

import '../entities/daily_report_entity.dart';
import '../entities/monthlys_report_entity.dart';
import '../entities/weekly_report_entity.dart';

abstract class ReportRepository {
  Future<DailyReportEntity> getDailyReport({required DateTime startDate});

  Future<WeeklyReportEntity> getWeeklyReport({required DateTime endDate});

  Future<MonthlyReportEntity> getMonthlyReport(
      {required int year, required int month});
}
