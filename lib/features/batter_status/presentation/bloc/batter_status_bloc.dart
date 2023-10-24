import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'batter_status_event.dart';
part 'batter_status_state.dart';

class BatterStatusBloc extends Bloc<BatterStatusEvent, BatterStatusState> {
  BatterStatusBloc() : super(BatterStatusInitial()) {
    on<BatterStatusEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
