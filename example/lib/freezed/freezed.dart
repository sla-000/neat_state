import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:example/freezed/app_state.dart';
import 'package:neat_state/neat_state.dart';

final NeatState<AppState> appState = NeatState<AppState>(
  initialState: const AppState(),
  onChangeCallback: (Change<AppState> change) {
    print('exampleFreezed:onChangeCallback: ${change.currentState} => ${change.nextState}');
  },
);

Future<void> exampleFreezed() async {
  print('exampleFreezed: init, counter=${appState.state.counter}');

  print('exampleFreezed: replace');
  appState.replace(appState.state.copyWith(counter: appState.state.counter + 1));

  print('exampleFreezed: update');
  appState.update((AppState state) => state.copyWith(counter: state.counter + 1));

  final StreamSubscription<AppState> subscription1 = appState.stream.listen((AppState state) {
    print('exampleFreezed:subscription1: counter=${state.counter}');
  });
  final StreamSubscription<int> subscription2 =
      appState.subState<int>((AppState state) => state.counter).listen((int counter) {
    print('exampleFreezed:subscription2: counter=$counter');
  });

  print('exampleFreezed: update 2');
  appState.update((AppState state) => state.copyWith(counter: state.counter + 1));

  await appState.stream.first;

  subscription1.cancel();
  subscription2.cancel();
}
