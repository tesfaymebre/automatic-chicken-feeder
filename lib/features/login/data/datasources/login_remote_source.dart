import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../user/data/model/user_model.dart';
import '../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});
  @override
  Future<UserModel> login(String email, String password) async {
    final respnse = await client.post(
      Uri.parse('https://food-dispenser-api.onrender.com/v1/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    print(respnse.body);
    if (respnse.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(respnse.body));
    } else {
      throw ServerException();
    }
  }
}
