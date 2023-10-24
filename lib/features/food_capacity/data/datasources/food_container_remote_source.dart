import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/shared/error_handler.dart';
import '../../../login/data/localdata/local_storage_data.dart';
import '../models/food_container_model.dart';

abstract class FoodContainerRemoteDataSource {
  Future<FoodContainerModel> getFoodContainerData();
}

class FoodContainerRemoteDataSourceImpl
    implements FoodContainerRemoteDataSource {
  final http.Client client;
  final LocalStorage localStorage;
  final String baseUrl =
      'https://food-dispenser-api.onrender.com/v1/feeding/capacity';

  FoodContainerRemoteDataSourceImpl(
      {required this.client, required this.localStorage});

  @override
  Future<FoodContainerModel> getFoodContainerData() async {
    try {
      final token = await localStorage.readFromStorage('Token');

      final response = await client.get(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Bearer ${token.toString()}",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return FoodContainerModel.fromJson(json.decode(response.body));
      } else {
        final errorMessage = ErrorHandler.handleError(response);
        throw Exception(errorMessage);
      }
    } catch (error) {
      final errorMessage = ErrorHandler.handleException(error);
      throw Exception(errorMessage);
    }
  }
}
