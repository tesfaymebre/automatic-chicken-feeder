import 'dart:convert';

import 'package:chicken_feeder/features/home_page/domain/entities/all_feeding_data_entity.dart';
import 'package:chicken_feeder/core/error/failures.dart';
import 'package:chicken_feeder/features/home_page/domain/entities/feeding_schedule_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/feeding_schedule_repository.dart';
import '../datasources/feeding_schedule_remote_datasource.dart';

class FeedingScheduleRepositoryImpl implements FeedingScheduleRepository {
  final FeedingScheduleRemoteDataSource feedingScheduleRemoteDataSource;

  FeedingScheduleRepositoryImpl(
      {required this.feedingScheduleRemoteDataSource});

  @override
  Future<FeedingScheduleEntity> createFeedingSchedule({
    required DateTime startDate,
    required DateTime endDate,
    required int amount,
    required int chickens,
    required String recurrence,
  }) async {
    // Convert the parameters to the appropriate format if needed
    // Call the remote data source to create the feeding schedule
    final response =
        await feedingScheduleRemoteDataSource.createFeedingSchedule(
      startDate: startDate,
      endDate: endDate,
      amount: amount,
      chickens: chickens,
      recurrence: recurrence,
    );

    return FeedingScheduleEntity(message: response.message ?? '');
  }

  @override
  Future<FeedingScheduleEntity> updateFeedingSchedule({
    required DateTime previousDate,
    required DateTime startDate,
    required DateTime endDate,
    required int amount,
    required int chickens,
    required String recurrence,
  }) async {
    // Convert the parameters to the appropriate format if needed
    // Call the remote data source to create the feeding schedule
    final response =
        await feedingScheduleRemoteDataSource.updateFeedingSchedule(
      previousDate: previousDate,
      startDate: startDate,
      endDate: endDate,
      amount: amount,
      chickens: chickens,
      recurrence: recurrence,
    );

    return FeedingScheduleEntity(message: response.message ?? '');
  }

  @override
  Future<FeedingScheduleEntity> deleteFeedingSchedule({
    required DateTime startDate,
  }) async {
    // Convert the parameters to the appropriate format if needed
    // Call the remote data source to create the feeding schedule
    final response =
        await feedingScheduleRemoteDataSource.deleteFeedingSchedule(
      startDate: startDate,
    );

    return FeedingScheduleEntity(message: response.message ?? '');
  }

  @override
  Future<List<AllFeedingDataEntity>> getAllFeedingData() async {
    final response = await feedingScheduleRemoteDataSource.getAllFeedingData();
    List<AllFeedingDataEntity> feedingDataEntities = response.data!
        .map((data) => AllFeedingDataEntity.fromData(data))
        .toList();

    return feedingDataEntities;
  }
}
