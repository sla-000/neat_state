import 'package:meta/meta.dart';

// Plain, stupid immutable state. Don't use it in the real project
@immutable
class AppState {
  const AppState({
    required this.counter,
  });

  final int counter;

  AppState copyWith({
    int? counter,
  }) {
    return AppState(
      counter: counter ?? this.counter,
    );
  }

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
