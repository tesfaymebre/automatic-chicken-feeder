class FoodContainerModel {
  String? message;
  Data? data;

  FoodContainerModel({this.message, this.data});

  FoodContainerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  double? currentCapacity;
  double? feedingCapacity;

  Data({this.currentCapacity, this.feedingCapacity});

  Data.fromJson(Map<String, dynamic> json) {
    currentCapacity = double.parse((json['currentCapacity']).toString());
    feedingCapacity = double.parse((json['feedingCapacity']).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentCapacity'] = this.currentCapacity;
    data['feedingCapacity'] = this.feedingCapacity;
    return data;
  }
}
