import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../../../login/domain/usecases/login.dart';
import '../../data/model/user_model.dart';
import '../../data/model/user_model_profile.dart';
import '../repository/user_repository.dart';

class UserProfile extends UseCase<UserModelProfile, Params> {
  final UserProfileRepository userProfileRepository;

  UserProfile(this.userProfileRepository);
  @override
  Future<Either<Failure, UserModelProfile>> call(Params params) {
    throw UnimplementedError();
  }

  Future<Either<Failure, UserModelProfile>> getUserProfile() async {
    final response = await userProfileRepository.getUserProfile();

    return response;
  }

  Future<Either<Failure, UserModelProfile>> updateUserProfile(
      Map<String, String> changes) async {
    final response = await userProfileRepository.updateUserProfile(changes);
    return response;
  }
}
