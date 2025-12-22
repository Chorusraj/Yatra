abstract class CounterState {
  final int count;
  const CounterState(this.count);
}

class InitialState extends CounterState {
  const InitialState() : super(0);
}

class UpdatedState extends CounterState {
  const UpdatedState(int count) : super(count);
}
