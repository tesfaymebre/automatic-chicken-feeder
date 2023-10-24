import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/shared/error_handler.dart';
import '../../../login/data/localdata/local_storage_data.dart';
import '../models/all_feeding_data_model.dart';
import '../models/feeding_schedule_model.dart';

abstract class FeedingScheduleRemoteDataSource {
  Future<FeedingScheduleModel> createFeedingSchedule({
    required DateTime startDate,
    required DateTime endDate,
    required int amount,
    required int chickens,
    required String recurrence,
  });

  Future<FeedingScheduleModel> updateFeedingSchedule({
    required DateTime previousDate,
    required DateTime startDate,
    required DateTime endDate,
    required int amount,
    required int chickens,
    required String recurrence,
  });

  Future<FeedingScheduleModel> deleteFeedingSchedule({
    required DateTime startDate,
  });

  Future<AllFeedingDataModel> getAllFeedingData();
}

class FeedingScheduleRemoteDataSourceImpl
    implements FeedingScheduleRemoteDataSource {
  final http.Client client;
  final LocalStorage localStorage;
  final String baseUrl = 'https://food-dispenser-api.onrender.com/v1/feeding';

  FeedingScheduleRemoteDataSourceImpl(
      {required this.client, required this.localStorage});

  Future<FeedingScheduleModel> createFeedingSchedule({
    required DateTime startDate,
    required DateTime endDate,
    required int amount,
    required int chickens,
    required String recurrence,
  }) async {
    try {
      final token = await localStorage.readFromStorage('Token');

      var body = json.encode(
        {
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
          'amount': amount.toString(),
          'chickens': chickens.toString(),
          'recurrence': recurrence,
        },
      );
      final response = await client.post(
        Uri.parse(baseUrl),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token.toString()}",
        },
      );

      print(response.body);

      if (response.statusCode == 201) {
        return FeedingScheduleModel.fromJson(json.decode(response.body));
      } else {
        final errorMessage = ErrorHandler.handleError(response);
        throw Exception(errorMessage);
      }
    } catch (error) {
      final errorMessage = ErrorHandler.handleException(error);
      throw Exception(errorMessage);
    }
  }

  Future<FeedingScheduleModel> updateFeedingSchedule({
    required DateTime previousDate,
    required DateTime startDate,
    required DateTime endDate,
    required int amount,
    required int chickens,
    required String recurrence,
  }) async {
    try {
      final token = await localStorage.readFromStorage('Token');

      var body = json.encode(
        {
          "previousDate": previousDate.toIso8601String(),
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
          'amount': amount.toString(),
          'chickens': chickens.toString(),
          'recurrence': recurrence,
        },
      );
      final response = await client.put(
        Uri.parse(baseUrl),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token.toString()}",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return FeedingScheduleModel.fromJson(json.decode(response.body));
      } else {
        final errorMessage = ErrorHandler.handleError(response);
        throw Exception(errorMessage);
      }
    } catch (error) {
      final errorMessage = ErrorHandler.handleException(error);
      throw Exception(errorMessage);
    }
  }

  Future<FeedingScheduleModel> deleteFeedingSchedule({
    required DateTime startDate,
  }) async {
    try {
      final token = await localStorage.readFromStorage('Token');

      var body = json.encode(
        {
          'startDate': startDate.toIso8601String(),
        },
      );
      final response = await client.delete(
        Uri.parse('${baseUrl}/delete'),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token.toString()}",
        },
      );

      print(response.body);

      if (response.statusCode == 201) {
        return FeedingScheduleModel.fromJson(json.decode(response.body));
      } else {
        final errorMessage = ErrorHandler.handleError(response);
        throw Exception(errorMessage);
      }
    } catch (error) {
      final errorMessage = ErrorHandler.handleException(error);
      throw Exception(errorMessage);
    }
  }

  @override
  Future<AllFeedingDataModel> getAllFeedingData() async {
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
        return AllFeedingDataModel.fromJson(json.decode(response.body));
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
