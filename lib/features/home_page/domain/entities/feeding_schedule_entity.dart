import 'package:equatable/equatable.dart';

class FeedingScheduleEntity extends Equatable {
  final String message;

  FeedingScheduleEntity({required this.message});

  @override
  List<Object?> get props => [message];
}
