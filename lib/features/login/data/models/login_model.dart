class LoginModel {
  final String email;
  final String firstName;

  const LoginModel(this.email, this.firstName) : super();

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(json['email'], json['firstName']);
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
    };
  }
}
