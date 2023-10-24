part of 'feeding_schedule_bloc.dart';

abstract class FeedingScheduleEvent extends Equatable {
  const FeedingScheduleEvent();

  @override
  List<Object> get props => [];
}

class CreateFeedingScheduleEvent extends FeedingScheduleEvent {
  final DateTime startDate;
  final DateTime endDate;
  final int amount;
  final int chickens;
  final String recurrence;

  CreateFeedingScheduleEvent({
    required this.startDate,
    required this.endDate,
    required this.amount,
    required this.chickens,
    required this.recurrence,
  });

  @override
  List<Object> get props => [startDate, endDate, amount, chickens, recurrence];
}

class UpdateFeedingScheduleEvent extends FeedingScheduleEvent {
  final DateTime previousDate;
  final DateTime startDate;
  final DateTime endDate;
  final int amount;
  final int chickens;
  final String recurrence;

  UpdateFeedingScheduleEvent({
    required this.previousDate,
    required this.startDate,
    required this.endDate,
    required this.amount,
    required this.chickens,
    required this.recurrence,
  });

  @override
  List<Object> get props =>
      [previousDate, startDate, endDate, amount, chickens, recurrence];
}

class DeleteFeedingScheduleEvent extends FeedingScheduleEvent {
  final DateTime startDate;

  DeleteFeedingScheduleEvent({
    required this.startDate,
  });

  @override
  List<Object> get props => [startDate];
}

class GetAllFeedingDataEvent extends FeedingScheduleEvent {
  GetAllFeedingDataEvent();

  @override
  List<Object> get props => [];
}
