import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yatra/features/test/event.dart';
import 'package:yatra/features/test/test_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitialState()) {
    on<IncrementEvent>((event, emit) {
      if (state is UpdatedState) {
        emit(UpdatedState((state as UpdatedState).count + 1));
      } else {
        emit(UpdatedState(1));
      }
    });

    on<DecrementEvent>((event, emit) {
      if (state is UpdatedState) {
        emit(UpdatedState((state as UpdatedState).count - 1));
      } else {
        emit(UpdatedState(-1));
      }
    });
  }
}
