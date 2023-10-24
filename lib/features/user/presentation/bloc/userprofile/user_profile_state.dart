part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileEditing extends UserProfileState {
  final UserModelProfile userModel;
  UserProfileEditing({required this.userModel});
}

class UserProfileEditedSuccess extends UserProfileState {}

class UserProfileLoadingFailed extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserModelProfile userModel;
  UserProfileLoaded({required this.userModel});
}
