part of 'analysis_bloc.dart';

abstract class AnalysisState extends Equatable {
  const AnalysisState();

  @override
  List<Object?> get props => [];
}

class AnalysisInitial extends AnalysisState {}

class DailyReportLoading extends AnalysisState {}

class DailyReportSuccess extends AnalysisState {
  final DailyReportEntity dailyReport;

  DailyReportSuccess({required this.dailyReport});

  @override
  List<Object?> get props => [dailyReport];
}

class DailyReportFailure extends AnalysisState {
  final String errorMessage;

  DailyReportFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class WeeklyReportLoading extends AnalysisState {}

class WeeklyReportSuccess extends AnalysisState {
  final WeeklyReportEntity weeklyReport;

  WeeklyReportSuccess({required this.weeklyReport});

  @override
  List<Object?> get props => [weeklyReport];
}

class WeeklyReportFailure extends AnalysisState {
  final String errorMessage;

  WeeklyReportFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class MonthlyReportLoading extends AnalysisState {}

class MonthlyReportSuccess extends AnalysisState {
  final MonthlyReportEntity monthlyReport;

  MonthlyReportSuccess({required this.monthlyReport});

  @override
  List<Object?> get props => [monthlyReport];
}

class MonthlyReportFailure extends AnalysisState {
  final String errorMessage;

  MonthlyReportFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
