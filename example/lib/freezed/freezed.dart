import 'dart:async';

import 'package:example/freezed/app_state.dart';
import 'package:neat_state/neat_state.dart';

final NeatState<AppState> appState = NeatState<AppState>(
  initialState: const AppState(),
);

Future<void> exampleFreezed() async {
  print('exampleFreezed:init: counter=${appState.state.counter}');

  appState.replace(appState.state.copyWith(counter: appState.state.counter + 1));
  print('exampleFreezed:replace: counter=${appState.state.counter}');

  appState.update((AppState state) => state.copyWith(counter: state.counter + 1));
  print('exampleFreezed:update: counter=${appState.state.counter}');

  final StreamSubscription<AppState> subscription1 = appState.stream.listen((AppState state) {
    print('exampleFreezed:listen1: counter=${state.counter}');
  });
  final StreamSubscription<int> subscription2 =
      appState.subState<int>((AppState state) => state.counter).listen((int counter) {
    print('exampleFreezed:listen2: counter=$counter');
  });

  appState.update((AppState state) => state.copyWith(counter: state.counter + 1));

  await appState.stream.first;

  subscription1.cancel();
  subscription2.cancel();
}
