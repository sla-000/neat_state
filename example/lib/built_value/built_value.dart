import 'dart:async';

import 'package:example/built_value/app_state.dart';
import 'package:neat_state/neat_state.dart';

final NeatState<AppState> appState = NeatState<AppState>(
  initialState: AppState(),
);

Future<void> exampleBuiltValue() async {
  print('exampleBuiltValue:init: counter=${appState.state.counter}');

  appState.replace(appState.state.rebuild((AppStateBuilder b) => b..counter = appState.state.counter + 1));
  print('exampleBuiltValue:replace: counter=${appState.state.counter}');

  appState.update((AppState state) => state.rebuild((AppStateBuilder b) => b..counter = state.counter + 1));
  print('exampleBuiltValue:update: counter=${appState.state.counter}');

  final StreamSubscription<AppState> subscription1 = appState.stream.listen((AppState state) {
    print('exampleBuiltValue:listen1: counter=${state.counter}');
  });
  final StreamSubscription<int> subscription2 =
      appState.subState<int>((AppState state) => state.counter).listen((int counter) {
    print('exampleBuiltValue:listen2: counter=$counter');
  });

  appState.update((AppState state) => state.rebuild((AppStateBuilder b) => b..counter = state.counter + 1));

  await appState.stream.first;

  subscription1.cancel();
  subscription2.cancel();
}
