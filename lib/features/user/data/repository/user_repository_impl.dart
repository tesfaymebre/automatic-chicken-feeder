import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../login/data/localdata/local_storage_data.dart';
import '../../domain/repository/user_repository.dart';
import '../datasource/user_data_source.dart';
import '../model/user_model.dart';
import '../model/user_model_profile.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDataSource userProfileDataSource;
  final LocalStorage localStorage;

  UserProfileRepositoryImpl(
      {required this.localStorage, required this.userProfileDataSource});
  @override
  Future<Either<Failure, UserModelProfile>> getUserProfile() async {
    try {
      final token = await localStorage.readFromStorage('token');
      final response = await userProfileDataSource.getUserProfile(token);

      return Right(response);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModelProfile>> updateUserProfile(
      Map<String, String> changes) async {
    try {
      // final token = await localStorage.readFromStorage('token');
      final response = await userProfileDataSource.updateUserProfile(changes);

      return Right(response);
    } catch (e) {
      return left(ServerFailure());
    }
  }
}
