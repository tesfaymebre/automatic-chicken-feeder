import 'dart:convert';

import 'package:chicken_feeder/features/home_page/domain/entities/all_feeding_data_entity.dart';
import 'package:chicken_feeder/core/error/failures.dart';
import 'package:chicken_feeder/features/home_page/domain/entities/feeding_schedule_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/food_container_entity.dart';
import '../../domain/repositories/food_container_repository.dart';
import '../datasources/food_container_remote_source.dart';

class FoodContainerRepositoryImpl implements FoodContainerRepository {
  final FoodContainerRemoteDataSource foodContainerRemoteDataSource;

  FoodContainerRepositoryImpl({required this.foodContainerRemoteDataSource});

  @override
  Future<FoodContainerEntity> getFoodContainerData() async {
    final response = await foodContainerRemoteDataSource.getFoodContainerData();

    return FoodContainerEntity(
        currentCapacity:
            double.parse((response.data!.currentCapacity!).toString()),
        feedingCapacity:
            double.parse((response.data!.feedingCapacity!).toString()));
  }
}
