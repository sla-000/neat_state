import 'dart:async';

import 'package:example/basic/app_state.dart';
import 'package:neat_state/neat_state.dart';

final NeatState<AppState> appState = NeatState<AppState>(
  initialState: const AppState(counter: 0),
);

Future<void> exampleBasic() async {
  print('exampleBasic:init: counter=${appState.state.counter}');

  appState.replace(AppState(counter: appState.state.counter + 1));
  print('exampleBasic:replace: counter=${appState.state.counter}');

  appState.update((AppState state) => AppState(counter: state.counter + 1));
  print('exampleBasic:update: counter=${appState.state.counter}');

  final StreamSubscription<AppState> subscription1 = appState.stream.listen((AppState state) {
    print('exampleBasic:listen1: counter=${state.counter}');
  });
  final StreamSubscription<int> subscription2 =
      appState.subState<int>((AppState state) => state.counter).listen((int counter) {
    print('exampleBasic:listen2: counter=$counter');
  });

  appState.update((AppState state) => AppState(counter: state.counter + 1));

  await appState.stream.first;

  subscription1.cancel();
  subscription2.cancel();
}
