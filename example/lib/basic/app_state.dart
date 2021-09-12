// Plain, stupid immutable state. Don't use it in the real project
class AppState {
  const AppState({
    required this.counter,
  });

  final int counter;
}
