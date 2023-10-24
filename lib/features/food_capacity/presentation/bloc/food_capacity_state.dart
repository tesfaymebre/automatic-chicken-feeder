part of 'food_capacity_bloc.dart';

abstract class FoodCapacityState extends Equatable {
  const FoodCapacityState();

  @override
  List<Object> get props => [];
}

class FoodCapacityInitial extends FoodCapacityState {}

class FoodCapacityDataLoading extends FoodCapacityInitial {}

class FoodCapacityDataSuccess extends FoodCapacityInitial {
  final FoodContainerEntity foodContainerEntity;

  FoodCapacityDataSuccess({required this.foodContainerEntity});

  @override
  List<Object> get props => [foodContainerEntity];
}

class FoodCapacityDataFailure extends FoodCapacityInitial {
  final String errorMessage;

  FoodCapacityDataFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
