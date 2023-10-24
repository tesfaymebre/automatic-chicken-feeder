import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/sign_up_entity.dart';
import '../../domain/usecases/sign_up_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on<CreateUserEvent>(_handleCreateUser);
  }

  Future<void> _handleCreateUser(
      CreateUserEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      final SignUpEntity signUpEntity = await signUpUseCase.createUser(
        full_name: event.full_name,
        email: event.email,
        password: event.password,
        phoneNumber: event.phoneNumber,
        device_id: event.device_id,
        city: event.city,
        subCity: event.subCity,
        woreda: event.woreda,
        street: event.street,
        houseNo: event.houseNo,
      );
      emit(SignUpSuccess(signUpEntity: signUpEntity));
    } catch (e) {
      emit(SignUpFailure(errorMessage: e.toString()));
    }
  }
}
