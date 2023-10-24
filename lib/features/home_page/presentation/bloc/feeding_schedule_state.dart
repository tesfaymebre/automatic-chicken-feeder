part of 'feeding_schedule_bloc.dart';

abstract class FeedingScheduleState extends Equatable {
  const FeedingScheduleState();

  @override
  List<Object?> get props => [];
}

class FeedingScheduleInitial extends FeedingScheduleState {}

class FeedingScheduleLoading extends FeedingScheduleState {}

class FeedingScheduleSuccess extends FeedingScheduleState {
  final FeedingScheduleEntity feedingSchedule;

  FeedingScheduleSuccess({required this.feedingSchedule});

  @override
  List<Object?> get props => [feedingSchedule];
}

class FeedingScheduleFailure extends FeedingScheduleState {
  final String errorMessage;

  FeedingScheduleFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class UpdateFeedingScheduleInitial extends FeedingScheduleState {}

class UpdateFeedingScheduleLoading extends FeedingScheduleState {}

class UpdateFeedingScheduleSuccess extends FeedingScheduleState {
  final FeedingScheduleEntity feedingSchedule;

  UpdateFeedingScheduleSuccess({required this.feedingSchedule});

  @override
  List<Object?> get props => [feedingSchedule];
}

class UpdateFeedingScheduleFailure extends FeedingScheduleState {
  final String errorMessage;

  UpdateFeedingScheduleFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class DeleteFeedingScheduleInitial extends FeedingScheduleState {}

class DeleteFeedingScheduleLoading extends FeedingScheduleState {}

class DeleteFeedingScheduleSuccess extends FeedingScheduleState {
  final FeedingScheduleEntity feedingSchedule;

  DeleteFeedingScheduleSuccess({required this.feedingSchedule});

  @override
  List<Object?> get props => [feedingSchedule];
}

class DeleteFeedingScheduleFailure extends FeedingScheduleState {
  final String errorMessage;

  DeleteFeedingScheduleFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class GetAllFeedingDataInitial extends FeedingScheduleState {}

class GetAllFeedingDataLoading extends FeedingScheduleState {}

class GetAllFeedingDataSuccess extends FeedingScheduleState {
  final List<AllFeedingDataEntity> allFeedingDataEntity;

  GetAllFeedingDataSuccess({required this.allFeedingDataEntity});

  @override
  List<Object?> get props => [allFeedingDataEntity];
}

class GetAllFeedingDataFailure extends FeedingScheduleState {
  final String errorMessage;

  GetAllFeedingDataFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
