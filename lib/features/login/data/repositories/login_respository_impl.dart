import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../user/data/model/user_model.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      final remoteResponse = await loginRemoteDataSource.login(email, password);
      return Right(remoteResponse);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
