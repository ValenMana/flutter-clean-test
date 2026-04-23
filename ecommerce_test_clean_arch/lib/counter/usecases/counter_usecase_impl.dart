import '../../core/domain/result.dart';
import '../../core/presentation/models/ui_error.dart';
import '../counter.dart';
import '../presentation/interfaces/counter_use_case.dart';
import 'interfaces/counter_manager.dart';

class CounterUseCaseImpl implements CounterUseCase {
  final CounterManager manager;

  CounterUseCaseImpl(this.manager);

  @override
  Future<Result<Counter, UiError>> getCounter() async {
    final result = await manager.getCounter();
    return switch (result) {
      Success(value: final counter) => Success(counter),
      Failure(error: final domainError) => Failure(
        UiError(domainError.message),
      ),
    };
  }

  @override
  Future<Result<Counter, UiError>> incrementCounter(int currentValue) async {
    final newValue = currentValue + 1;
    final result = await manager.saveCounter(newValue);
    return switch (result) {
      Success(value: final counter) => Success(counter),
      Failure(error: final domainError) => Failure(
        UiError(domainError.message),
      ),
    };
  }
}
