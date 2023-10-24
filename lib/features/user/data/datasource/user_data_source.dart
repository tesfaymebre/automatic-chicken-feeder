import 'dart:convert';

import 'package:chicken_feeder/features/user/data/model/user_model_profile.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../login/data/localdata/local_storage_data.dart';
import '../model/user_model.dart';

abstract class UserProfileDataSource {
  Future<UserModelProfile> getUserProfile(String token);
  Future<UserModelProfile> updateUserProfile(Map<String, String> changes);
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final http.Client client;
  final LocalStorage localStorage;

  UserProfileDataSourceImpl({required this.localStorage, required this.client});
  @override
  Future<UserModelProfile> getUserProfile(String token) async {
    try {
      final user = await localStorage.readFromStorage('Token');
      print(user);
      final response = await client.get(
        Uri.parse('https://food-dispenser-api.onrender.com/v1/user'),
        headers: {
          "Authorization": "Bearer ${user.toString()}",
          'Content-Type': 'application/json'
        },
      );
      UserModelProfile ans =
          UserModelProfile.fromJson(jsonDecode(response.body));
      await localStorage.writeToStorage('UserType', token);
      print(ans);

      return ans;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<UserModelProfile> updateUserProfile(
      Map<String, String> changes) async {
    try {
      final token = await localStorage.readFromStorage('Token');
      final response = await client.put(
        Uri.parse('https://food-dispenser-api.onrender.com/v1/user/'),
        body: jsonEncode(changes),
        headers: {
          "Authorization": "Bearer ${token.toString()}",
          'Content-Type': 'application/json',
        },
      );

      final r = UserModelProfile.fromJson(jsonDecode(response.body));

      return r;
    } catch (e) {
      throw e;
    }
  }
}
