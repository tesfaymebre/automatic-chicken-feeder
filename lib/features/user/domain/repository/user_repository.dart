import 'package:chicken_feeder/features/user/data/model/user_model_profile.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/user_model.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserModelProfile>> getUserProfile();
  Future<Either<Failure, UserModelProfile>> updateUserProfile(
      Map<String, String> changes);
}
