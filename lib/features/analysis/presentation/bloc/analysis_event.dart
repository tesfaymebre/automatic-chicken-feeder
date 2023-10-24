part of 'analysis_bloc.dart';

abstract class AnalysisEvent extends Equatable {
  const AnalysisEvent();

  @override
  List<Object> get props => [];
}

class GetDailyReportEvent extends AnalysisEvent {
  final DateTime startDate;

  GetDailyReportEvent({
    required this.startDate,
  });

  @override
  List<Object> get props => [startDate];
}

class GetWeeklyReportEvent extends AnalysisEvent {
  final DateTime endDate;

  GetWeeklyReportEvent({
    required this.endDate,
  });

  @override
  List<Object> get props => [endDate];
}

class GetMonthlyReportEvent extends AnalysisEvent {
  final int year;
  final int month;

  GetMonthlyReportEvent({
    required this.year,
    required this.month,
  });

  @override
  List<Object> get props => [year, month];
}
