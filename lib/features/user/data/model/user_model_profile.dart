class UserModelProfile {
  String? sId;
  String? fullName;
  String? email;
  bool? isAdmin;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserModelProfile(
      {this.sId,
      this.fullName,
      this.email,
      this.isAdmin,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserModelProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['full_name'];
    email = json['email'];
    isAdmin = json['isAdmin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['isAdmin'] = this.isAdmin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
