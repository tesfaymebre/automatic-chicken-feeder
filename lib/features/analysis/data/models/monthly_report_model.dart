class MonthlyReportModel {
  String? message;
  Report? report;

  MonthlyReportModel({this.message, this.report});

  MonthlyReportModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    report =
        json['report'] != null ? new Report.fromJson(json['report']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    return data;
  }
}

class Report {
  int? year;
  int? month;
  String? startDate;
  String? endDate;
  int? totalFoodConsumption;
  String? averageFoodConsumptionPerFeeding;
  int? numFeedings;
  String? successRate;
  String? failureRate;
  List<SuccessDataPoints>? successDataPoints;
  List<FailureDataPoints>? failureDataPoints;

  Report(
      {this.year,
      this.month,
      this.startDate,
      this.endDate,
      this.totalFoodConsumption,
      this.averageFoodConsumptionPerFeeding,
      this.numFeedings,
      this.successRate,
      this.failureRate,
      this.successDataPoints,
      this.failureDataPoints});

  Report.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    totalFoodConsumption = json['totalFoodConsumption'];
    averageFoodConsumptionPerFeeding = json['averageFoodConsumptionPerFeeding'];
    numFeedings = json['numFeedings'];
    successRate = json['successRate'];
    failureRate = json['failureRate'];
    if (json['successDataPoints'] != null) {
      successDataPoints = <SuccessDataPoints>[];
      json['successDataPoints'].forEach((v) {
        successDataPoints!.add(new SuccessDataPoints.fromJson(v));
      });
    }
    if (json['failureDataPoints'] != null) {
      failureDataPoints = <FailureDataPoints>[];
      json['failureDataPoints'].forEach((v) {
        failureDataPoints!.add(new FailureDataPoints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['totalFoodConsumption'] = this.totalFoodConsumption;
    data['averageFoodConsumptionPerFeeding'] =
        this.averageFoodConsumptionPerFeeding;
    data['numFeedings'] = this.numFeedings;
    data['successRate'] = this.successRate;
    data['failureRate'] = this.failureRate;
    if (this.successDataPoints != null) {
      data['successDataPoints'] =
          this.successDataPoints!.map((v) => v.toJson()).toList();
    }
    if (this.failureDataPoints != null) {
      data['failureDataPoints'] =
          this.failureDataPoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuccessDataPoints {
  String? date;
  int? amount;
  String? averageFoodConsumptionPerFeeding;
  int? numFeedings;
  int? chickens;

  SuccessDataPoints(
      {this.date,
      this.amount,
      this.averageFoodConsumptionPerFeeding,
      this.numFeedings,
      this.chickens});

  SuccessDataPoints.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
    averageFoodConsumptionPerFeeding = json['averageFoodConsumptionPerFeeding'];
    numFeedings = json['numFeedings'];
    chickens = json['chickens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['averageFoodConsumptionPerFeeding'] =
        this.averageFoodConsumptionPerFeeding;
    data['numFeedings'] = this.numFeedings;
    data['chickens'] = this.chickens;
    return data;
  }
}

class FailureDataPoints {
  String? date;
  int? amount;
  String? averageFoodConsumptionPerFeeding;
  int? numFeedings;
  int? chickens;

  FailureDataPoints(
      {this.date,
      this.amount,
      this.averageFoodConsumptionPerFeeding,
      this.numFeedings,
      this.chickens});

  FailureDataPoints.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
    averageFoodConsumptionPerFeeding = json['averageFoodConsumptionPerFeeding'];
    numFeedings = json['numFeedings'];
    chickens = json['chickens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['averageFoodConsumptionPerFeeding'] =
        this.averageFoodConsumptionPerFeeding;
    data['numFeedings'] = this.numFeedings;
    data['chickens'] = this.chickens;
    return data;
  }
}
