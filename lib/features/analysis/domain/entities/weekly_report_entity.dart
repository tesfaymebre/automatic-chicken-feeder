import '../../data/models/weekly_report_model.dart';

class WeeklyReportEntity {
  final String? message;
  final ReportEntity? report;

  WeeklyReportEntity({this.message, this.report});

  factory WeeklyReportEntity.fromModel(WeeklyReportModel model) {
    return WeeklyReportEntity(
      message: model.message,
      report:
          model.report != null ? ReportEntity.fromModel(model.report!) : null,
    );
  }
}

class ReportEntity {
  final String? startDate;
  final String? endDate;
  final int? totalFoodConsumption;
  final double? averageFoodConsumptionPerFeeding;
  final int? numFeedings;
  final double? successRate;
  final double? failureRate;
  final List<SuccessDataPointsEntity>? successDataPoints;
  final List<FailureDataPointsEntity>? failureDataPoints;

  ReportEntity({
    this.startDate,
    this.endDate,
    this.totalFoodConsumption,
    this.averageFoodConsumptionPerFeeding,
    this.numFeedings,
    this.successRate,
    this.failureRate,
    this.successDataPoints,
    this.failureDataPoints,
  });

  factory ReportEntity.fromModel(Report model) {
    return ReportEntity(
      startDate: model.startDate,
      endDate: model.endDate,
      totalFoodConsumption: model.totalFoodConsumption,
      averageFoodConsumptionPerFeeding:
          double.parse(model.averageFoodConsumptionPerFeeding!),
      numFeedings: model.numFeedings,
      successRate: double.parse(model.successRate!),
      failureRate: double.parse(model.failureRate!),
      successDataPoints: model.successDataPoints != null
          ? model.successDataPoints!
              .map((e) => SuccessDataPointsEntity.fromModel(e))
              .toList()
          : null,
      failureDataPoints: model.failureDataPoints != null
          ? model.failureDataPoints!
              .map((e) => FailureDataPointsEntity.fromModel(e))
              .toList()
          : null,
    );
  }
}

class SuccessDataPointsEntity {
  final String? date;
  final int? amount;
  final double? averageFoodConsumptionPerFeeding;
  final int? numFeedings;
  final int? chickens;

  SuccessDataPointsEntity({
    this.date,
    this.amount,
    this.averageFoodConsumptionPerFeeding,
    this.numFeedings,
    this.chickens,
  });

  factory SuccessDataPointsEntity.fromModel(SuccessDataPoints model) {
    return SuccessDataPointsEntity(
      date: model.date,
      amount: model.amount,
      averageFoodConsumptionPerFeeding:
          double.parse(model.averageFoodConsumptionPerFeeding!),
      numFeedings: model.numFeedings,
      chickens: model.chickens,
    );
  }
}

class FailureDataPointsEntity {
  final String? date;
  final int? amount;
  final double? averageFoodConsumptionPerFeeding;
  final int? numFeedings;
  final int? chickens;

  FailureDataPointsEntity({
    this.date,
    this.amount,
    this.averageFoodConsumptionPerFeeding,
    this.numFeedings,
    this.chickens,
  });

  factory FailureDataPointsEntity.fromModel(FailureDataPoints model) {
    return FailureDataPointsEntity(
      date: model.date,
      amount: model.amount,
      averageFoodConsumptionPerFeeding:
          double.parse(model.averageFoodConsumptionPerFeeding!),
      numFeedings: model.numFeedings,
      chickens: model.chickens,
    );
  }
}
