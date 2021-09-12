import 'package:bloc/bloc.dart';

/// NeatState is just cubit with global state of your app
/// initialState - Initial state
class NeatState<S> extends Cubit<S> {
  NeatState({
    required S initialState,
  }) : super(initialState);

  /// Replace global state with a state from parameter state
  void replace(S state) => emit(state);

  /// Update global state with a stateUpdater function - sometimes it's more convenient than use replace
  void update(S Function(S state) stateUpdater) => replace(stateUpdater(state));

  /// Get a substate of the state with a mapper function
  Stream<T> subState<T>(T Function(S state) mapper) => stream.map<T>(mapper).distinct();
}
