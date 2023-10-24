import 'package:bloc/bloc.dart';
import 'package:chicken_feeder/features/analysis/domain/usecases/report_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/daily_report_entity.dart';
import '../../domain/entities/monthlys_report_entity.dart';
import '../../domain/entities/weekly_report_entity.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  final ReportUseCase reportUseCase;
  AnalysisBloc({required this.reportUseCase}) : super(AnalysisInitial()) {
    on<GetDailyReportEvent>(_getDailyReport);
    on<GetWeeklyReportEvent>(_getWeeklyReport);
    on<GetMonthlyReportEvent>(_getMonthlyReport);
  }

  Future<void> _getDailyReport(
      GetDailyReportEvent event, Emitter<AnalysisState> emit) async {
    emit(DailyReportLoading());
    try {
      final DailyReportEntity dailyReport =
          await reportUseCase.getDailyReport(startDate: event.startDate);
      print(dailyReport);
      emit(DailyReportSuccess(dailyReport: dailyReport));
    } catch (e) {
      emit(DailyReportFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _getWeeklyReport(
      GetWeeklyReportEvent event, Emitter<AnalysisState> emit) async {
    emit(WeeklyReportLoading());
    try {
      final WeeklyReportEntity weeklyReport =
          await reportUseCase.getWeeklyReport(endDate: event.endDate);
      print(weeklyReport);
      emit(WeeklyReportSuccess(weeklyReport: weeklyReport));
    } catch (e) {
      emit(WeeklyReportFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _getMonthlyReport(
      GetMonthlyReportEvent event, Emitter<AnalysisState> emit) async {
    emit(MonthlyReportLoading());
    try {
      final MonthlyReportEntity monthlyReport = await reportUseCase
          .getMonthlyReport(year: event.year, month: event.month);
      emit(MonthlyReportSuccess(monthlyReport: monthlyReport));
    } catch (e) {
      emit(MonthlyReportFailure(errorMessage: e.toString()));
    }
  }
}
