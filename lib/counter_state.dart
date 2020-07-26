class CounterState {
  int counter;

  CounterState._(); // private constructor

  // factory for the initial state (when the app is started)
  factory CounterState.initial() {
    return CounterState._()..counter = 0; // this would be an api call usually
  }
}