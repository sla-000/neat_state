import 'package:built_value/built_value.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void Function(AppStateBuilder)? updates]) = _$AppState;
  AppState._();

  static void _initializeBuilder(AppStateBuilder builder) => builder..counter = 0;

  int get counter;
}
