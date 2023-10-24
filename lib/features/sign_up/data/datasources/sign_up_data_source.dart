import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../login/data/localdata/local_storage_data.dart';
import '../models/sign_up_model.dart';

abstract class SignUpRemoteDataSource {
  Future<SignUpModel> createUser({
    required String full_name,
    required String email,
    required String password,
    required String device_id,
    required String phoneNumber,
    required String city,
    required String subCity,
    required String woreda,
    required String street,
    required String houseNo,
  });
}

class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://food-dispenser-api.onrender.com/v1/user';

  SignUpRemoteDataSourceImpl({required this.client});

  Future<SignUpModel> createUser({
    required String full_name,
    required String email,
    required String password,
    required String device_id,
    required String phoneNumber,
    required String city,
    required String subCity,
    required String woreda,
    required String street,
    required String houseNo,
  }) async {
    var body = json.encode(
      {
        "full_name": full_name,
        "email": email,
        "password": password,
        "device_id": device_id,
        "phoneNumber": phoneNumber,
        "city": city,
        "subCity": subCity,
        "woreda": woreda,
        "street": street,
        "houseNo": houseNo
      },
    );
    final response = await client.post(
      Uri.parse(baseUrl),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.body);

    if (response.statusCode == 201) {
      return SignUpModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create new user');
    }
  }
}
