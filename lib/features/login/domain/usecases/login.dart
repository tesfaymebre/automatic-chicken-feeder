import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../../../user/data/model/user_model.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repository.dart';

class Login implements UseCase<UserModel, Params> {
  final LoginRepository repository;

  Login(this.repository);
  @override
  Future<Either<Failure, UserModel>> call(Params params) async {
    return await repository.login(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({required this.email, required this.password}) : super();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
