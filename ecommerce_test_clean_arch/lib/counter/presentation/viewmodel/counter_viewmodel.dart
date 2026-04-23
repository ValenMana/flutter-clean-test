import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/domain/result.dart';
import '../../../core/presentation/viewstate/view_state.dart';
import '../../di/counter_providers.dart';
import 'counter_state.dart';

part 'counter_viewmodel.g.dart';

@riverpod
class CounterViewModel extends _$CounterViewModel {
  @override
  CounterState build() {
    _loadCounter();
    return const CounterState(viewState: Loading());
  }

  Future<void> _loadCounter() async {
    final useCase = ref.read(counterUseCaseProvider);
    final result = await useCase.getCounter();

    state = switch (result) {
      Success(value: final counter) => state.copyWith(
        counterValue: counter.value,
        viewState: const Ready(),
      ),
      Failure(error: final uiError) => state.copyWith(
        viewState: ErrorState(uiError.message),
      ),
    };
  }

  Future<void> increment() async {
    state = state.copyWith(viewState: const Loading());
    final useCase = ref.read(counterUseCaseProvider);
    final result = await useCase.incrementCounter(state.counterValue);

    state = switch (result) {
      Success(value: final counter) => state.copyWith(
        counterValue: counter.value,
        viewState: const Ready(),
      ),
      Failure(error: final uiError) => state.copyWith(
        viewState: ErrorState(uiError.message),
      ),
    };
  }

  void clearError() {
    state = state.copyWith(viewState: const Ready());
  }
}
