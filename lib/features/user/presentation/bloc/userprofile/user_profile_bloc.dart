import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user_model.dart';
import '../../../data/model/user_model_profile.dart';
import '../../../domain/usecases/user_profile.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfile userProfile;
  UserProfileBloc({required this.userProfile}) : super(UserProfileInitial()) {
    on<LoadUserProfile>((event, emit) async {
      emit(UserProfileLoading());

      final response = await userProfile.getUserProfile();
      print(response);
      emit(UserProfileLoaded(
          userModel: response.getOrElse(() => UserModelProfile())));
    });

    on<EditUserProfile>((event, emit) async {
      final response = await userProfile.getUserProfile();

      emit(UserProfileEditing(
          userModel: response.getOrElse(() => UserModelProfile())));
    });

    on<UpdateUserProfile>((event, emit) async {
      final response = await userProfile.updateUserProfile(event.changes);
      final responseL = await userProfile.getUserProfile();

      emit(UserProfileLoaded(
          userModel: responseL.getOrElse(() => UserModelProfile())));
      emit(UserProfileEditedSuccess());
    });
  }
}
