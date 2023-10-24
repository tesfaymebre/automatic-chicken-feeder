class AllFeedingDataModel {
  List<Data>? data;

  AllFeedingDataModel({this.data});

  AllFeedingDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? user;
  String? device;
  int? amount;
  int? chickens;
  String? startDate;
  String? endDate;
  String? recurrence;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.user,
      this.device,
      this.amount,
      this.chickens,
      this.startDate,
      this.endDate,
      this.recurrence,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    device = json['device'];
    amount = json['amount'];
    chickens = json['chickens'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    recurrence = json['recurrence'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['device'] = this.device;
    data['amount'] = this.amount;
    data['chickens'] = this.chickens;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['recurrence'] = this.recurrence;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
