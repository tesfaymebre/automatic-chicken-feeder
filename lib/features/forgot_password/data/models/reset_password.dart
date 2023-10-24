class ResetPassword {
  String? otp;
  String? password;

  ResetPassword({this.otp, this.password});

  ResetPassword.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['password'] = this.password;
    return data;
  }
}
