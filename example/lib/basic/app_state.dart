// Plain, stupid immutable state. Don't use it in the real project
import 'package:meta/meta.dart';

@immutable
class AppState {
  const AppState({
    required this.counter,
  });

  final int counter;

  @override
  String toString() {
    return 'AppState{counter: $counter}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AppState && runtimeType == other.runtimeType && counter == other.counter;

  @override
  int get hashCode => counter.hashCode;
}
