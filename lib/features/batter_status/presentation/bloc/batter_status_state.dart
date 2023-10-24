part of 'batter_status_bloc.dart';

abstract class BatterStatusState extends Equatable {
  const BatterStatusState();  

  @override
  List<Object> get props => [];
}
class BatterStatusInitial extends BatterStatusState {}
