import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:example/built_value/app_state.dart';
import 'package:neat_state/neat_state.dart';

extension PrettyPrint on AppState {
  String get log => toString().replaceAll(RegExp(r'[\n|\s]'), '');
}

final NeatState<AppState> appState = NeatState<AppState>(
  initialState: AppState(),
  onChangeCallback: (Change<AppState> change) {
    print('exampleBuiltValue:onChangeCallback: ${change.currentState.log} => ${change.nextState.log}');
  },
);

Future<void> exampleBuiltValue() async {
  print('exampleBuiltValue: init, counter=${appState.state.counter}');

  print('exampleBuiltValue: replace');
  appState.replace(appState.state.rebuild((AppStateBuilder b) => b..counter = appState.state.counter + 1));

  print('exampleBuiltValue: update');
  appState.update((AppState state) => state.rebuild((AppStateBuilder b) => b..counter = state.counter + 1));

  final StreamSubscription<AppState> subscription1 = appState.stream.listen((AppState state) {
    print('exampleBuiltValue:subscription1: counter=${state.counter}');
  });
  final StreamSubscription<int> subscription2 =
      appState.subState<int>((AppState state) => state.counter).listen((int counter) {
    print('exampleBuiltValue:subscription2: counter=$counter');
  });

  print('exampleBuiltValue: update 2');
  appState.update((AppState state) => state.rebuild((AppStateBuilder b) => b..counter = state.counter + 1));

  await appState.stream.first;

  subscription1.cancel();
  subscription2.cancel();
}
