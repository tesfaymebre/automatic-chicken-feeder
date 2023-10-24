import 'package:bloc/bloc.dart';
import 'package:chicken_feeder/features/food_capacity/domain/usecases/food_container_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/food_container_entity.dart';

part 'food_capacity_event.dart';
part 'food_capacity_state.dart';

class FoodCapacityBloc extends Bloc<FoodCapacityEvent, FoodCapacityState> {
  FoodContainerUseCase foodContainerUseCase;
  FoodCapacityBloc({required this.foodContainerUseCase})
      : super(FoodCapacityInitial()) {
    on<GetFoodContainerDataEvent>(_getFoodContainerData);
  }

  Future<void> _getFoodContainerData(
      GetFoodContainerDataEvent event, Emitter<FoodCapacityState> emit) async {
    emit(FoodCapacityDataLoading());
    try {
      final FoodContainerEntity foodContainerEntity =
          await foodContainerUseCase.getFoodContainerData();
      emit(FoodCapacityDataSuccess(foodContainerEntity: foodContainerEntity));
    } catch (e) {
      emit(FoodCapacityDataFailure(errorMessage: e.toString()));
    }
  }
}
