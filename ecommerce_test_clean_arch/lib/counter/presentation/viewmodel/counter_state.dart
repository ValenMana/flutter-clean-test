import '../../../core/presentation/viewstate/view_state.dart';

class CounterState {
  final int counterValue;
  final ViewState<void> viewState;

  const CounterState({this.counterValue = 0, this.viewState = const Ready()});

  CounterState copyWith({int? counterValue, ViewState<void>? viewState}) {
    return CounterState(
      counterValue: counterValue ?? this.counterValue,
      viewState: viewState ?? this.viewState,
    );
  }
}
