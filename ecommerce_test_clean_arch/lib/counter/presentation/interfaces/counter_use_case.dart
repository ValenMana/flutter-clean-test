import '../../../core/domain/result.dart';
import '../../../core/presentation/models/ui_error.dart';
import '../../counter.dart';

abstract class CounterUseCase {
  Future<Result<Counter, UiError>> getCounter();
  Future<Result<Counter, UiError>> incrementCounter(int currentValue);
}
