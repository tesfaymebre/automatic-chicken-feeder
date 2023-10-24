part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfile extends UserProfileEvent {}

class EditUserProfile extends UserProfileEvent {}

class UpdateUserProfile extends UserProfileEvent {
  final Map<String, String> changes;

  UpdateUserProfile({required this.changes});
}
