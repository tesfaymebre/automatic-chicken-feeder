import '../entities/daily_report_entity.dart';
import '../entities/monthlys_report_entity.dart';
import '../entities/weekly_report_entity.dart';
import '../repositories/report_repository.dart';

class ReportUseCase {
  final ReportRepository reportRepository;

  ReportUseCase({required this.reportRepository});

  Future<DailyReportEntity> getDailyReport({
    required DateTime startDate,
  }) async {
    final result = await reportRepository.getDailyReport(
      startDate: startDate,
    );

    // Return the entity representing the successful message
    return result;
  }

  Future<WeeklyReportEntity> getWeeklyReport({
    required DateTime endDate,
  }) async {
    final result = await reportRepository.getWeeklyReport(
      endDate: endDate,
    );

    // Return the entity representing the successful message
    return result;
  }

  Future<MonthlyReportEntity> getMonthlyReport({
    required int year,
    required int month,
  }) async {
    final result = await reportRepository.getMonthlyReport(
      year: year,
      month: month,
    );

    // Return the entity representing the successful message
    return result;
  }
}
