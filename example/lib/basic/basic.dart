import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:example/basic/app_state.dart';
import 'package:neat_state/neat_state.dart';

final NeatState<AppState> appState = NeatState<AppState>(
  initialState: const AppState(counter: 0),
  onChangeCallback: (Change<AppState> change) {
    print('exampleBasic:onChangeCallback: ${change.currentState} => ${change.nextState}');
  },
);

Future<void> exampleBasic() async {
  print('exampleBasic: init, counter=${appState.state.counter}');

  print('exampleBasic: replace');
  appState.replace(AppState(counter: appState.state.counter + 1));

  print('exampleBasic: update');
  appState.update((AppState state) => AppState(counter: state.counter + 1));

  final StreamSubscription<AppState> subscription1 = appState.stream.listen((AppState state) {
    print('exampleBasic:subscription1: counter=${state.counter}');
  });
  final StreamSubscription<int> subscription2 =
      appState.subState<int>((AppState state) => state.counter).listen((int counter) {
    print('exampleBasic:subscription2: counter=$counter');
  });

  print('exampleBasic: update 2');
  appState.update((AppState state) => AppState(counter: state.counter + 1));

  await appState.stream.first;

  subscription1.cancel();
  subscription2.cancel();
}
