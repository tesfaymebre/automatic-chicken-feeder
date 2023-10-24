import 'package:chicken_feeder/features/home_page/domain/usecases/all_feeding_data_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/all_feeding_data_entity.dart';
import '../../domain/entities/feeding_schedule_entity.dart';
import '../../domain/usecases/feeding_schedule_usecase.dart';

part 'feeding_schedule_event.dart';
part 'feeding_schedule_state.dart';

class FeedingScheduleBloc
    extends Bloc<FeedingScheduleEvent, FeedingScheduleState> {
  final FeedingScheduleUseCase feedingScheduleUseCase;
  final AllFeedingDataUseCase allFeedingDataUseCase;

  FeedingScheduleBloc(
      {required this.allFeedingDataUseCase,
      required this.feedingScheduleUseCase})
      : super(FeedingScheduleInitial()) {
    on<CreateFeedingScheduleEvent>(_handleCreateFeedingSchedule);
    on<UpdateFeedingScheduleEvent>(_updateFeedingSchedule);
    on<GetAllFeedingDataEvent>(_getAllFeedingData);
    on<DeleteFeedingScheduleEvent>(_deleteFeedingSchedule);
  }

  Future<void> _handleCreateFeedingSchedule(CreateFeedingScheduleEvent event,
      Emitter<FeedingScheduleState> emit) async {
    emit(FeedingScheduleLoading());
    try {
      final FeedingScheduleEntity feedingSchedule =
          await feedingScheduleUseCase.createFeedingSchedule(
        startDate: event.startDate,
        endDate: event.endDate,
        amount: event.amount,
        chickens: event.chickens,
        recurrence: event.recurrence,
      );
      emit(FeedingScheduleSuccess(feedingSchedule: feedingSchedule));
    } catch (e) {
      emit(FeedingScheduleFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _updateFeedingSchedule(UpdateFeedingScheduleEvent event,
      Emitter<FeedingScheduleState> emit) async {
    emit(UpdateFeedingScheduleLoading());
    try {
      final FeedingScheduleEntity feedingSchedule =
          await feedingScheduleUseCase.updateFeedingSchedule(
        previousDate: event.previousDate,
        startDate: event.startDate,
        endDate: event.endDate,
        amount: event.amount,
        chickens: event.chickens,
        recurrence: event.recurrence,
      );
      emit(UpdateFeedingScheduleSuccess(feedingSchedule: feedingSchedule));
    } catch (e) {
      emit(UpdateFeedingScheduleFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _deleteFeedingSchedule(DeleteFeedingScheduleEvent event,
      Emitter<FeedingScheduleState> emit) async {
    emit(DeleteFeedingScheduleLoading());
    try {
      final FeedingScheduleEntity feedingSchedule =
          await feedingScheduleUseCase.deleteFeedingSchedule(
        startDate: event.startDate,
      );
      emit(DeleteFeedingScheduleSuccess(feedingSchedule: feedingSchedule));
    } catch (e) {
      emit(DeleteFeedingScheduleFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _getAllFeedingData(
      GetAllFeedingDataEvent event, Emitter<FeedingScheduleState> emit) async {
    emit(GetAllFeedingDataLoading());
    try {
      final List<AllFeedingDataEntity> allFeedingDataEntity =
          await allFeedingDataUseCase.getAllFeedingData();
      emit(
          GetAllFeedingDataSuccess(allFeedingDataEntity: allFeedingDataEntity));
    } catch (e) {
      emit(FeedingScheduleFailure(errorMessage: e.toString()));
    }
  }
}
