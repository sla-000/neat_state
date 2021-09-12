Nice and simple app global state based on bloc package

## Usage

Create a global state for your app (add optional onChangeCallback):
```dart
final NeatState<AppState> appState = NeatState<AppState>(
  initialState: const AppState(counter: 0),
  onChangeCallback: (Change<AppState> change) {
    print('exampleBasic:onChangeCallback: ${change.currentState} => ${change.nextState}');
  },
);
```

Get access to value of state:
```dart
print('exampleBasic: init, counter=${appState.state.counter}');
```

Change state with replace method:
```dart
appState.replace(appState.state.copyWith(counter: appState.state.counter + 1));
```
or with update method (sometimes it may be more convenient):
```dart
appState.update((AppState state) => state.copyWith(counter: state.counter + 1));
```

Listen to the state changes:
```dart
final StreamSubscription<AppState> subscription1 = appState.stream.listen((AppState state) {
  print('exampleBasic:subscription1: counter=${state.counter}');
});
```

Listen only to some part of state changes:
```dart
final StreamSubscription<int> subscription2 =
      appState.subState<int>((AppState state) => state.counter).listen((int counter) {
    print('exampleBasic:subscription2: counter=$counter');
  });
```

## Additional information

- [bloc](https://pub.dev/packages/bloc)
- [Single source of truth](https://en.wikipedia.org/wiki/Single_source_of_truth)
