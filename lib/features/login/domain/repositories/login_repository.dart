import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../features/user/data/model/user_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserModel>> login(String email, String password);
}
