class DailyReportModel {
  String? message;
  Report? report;

  DailyReportModel({this.message, this.report});

  DailyReportModel.fromJson(Map<String, dynamic> json) {
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
  String? start;
  String? end;
  int? totalFoodConsumption;
  String? averageFoodConsumptionPerFeeding;
  int? numFeedings;
  String? successRate;
  String? failureRate;
  List<SuccessDataPoints>? successDataPoints;
  List<FailureDataPoints>? failureDataPoints;

  Report(
      {this.start,
      this.end,
      this.totalFoodConsumption,
      this.averageFoodConsumptionPerFeeding,
      this.numFeedings,
      this.successRate,
      this.failureRate,
      this.successDataPoints,
      this.failureDataPoints});

  Report.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
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
    data['start'] = this.start;
    data['end'] = this.end;
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
  int? chickens;

  SuccessDataPoints({this.date, this.amount, this.chickens});

  SuccessDataPoints.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
    chickens = json['chickens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['chickens'] = this.chickens;
    return data;
  }
}

class FailureDataPoints {
  String? date;
  int? amount;
  int? chickens;

  FailureDataPoints({this.date, this.amount, this.chickens});

  FailureDataPoints.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
    chickens = json['chickens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['chickens'] = this.chickens;
    return data;
  }
}
