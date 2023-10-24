import 'dart:convert';

import 'package:chicken_feeder/features/home_page/domain/entities/all_feeding_data_entity.dart';
import 'package:chicken_feeder/core/error/failures.dart';
import 'package:chicken_feeder/features/home_page/domain/entities/feeding_schedule_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/sign_up_entity.dart';
import '../../domain/repositories/sign_up_repository.dart';
import '../datasources/sign_up_data_source.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource signUpRemoteDataSource;

  SignUpRepositoryImpl({required this.signUpRemoteDataSource});

  @override
  Future<SignUpEntity> createUser({
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
    // Convert the parameters to the appropriate format if needed
    // Call the remote data source to create the feeding schedule
    final response = await signUpRemoteDataSource.createUser(
      full_name: full_name,
      email: email,
      password: password,
      device_id: device_id,
      phoneNumber: phoneNumber,
      city: city,
      subCity: subCity,
      woreda: woreda,
      street: street,
      houseNo: houseNo,
    );

    return SignUpEntity(message: response.message ?? '');
  }
}
