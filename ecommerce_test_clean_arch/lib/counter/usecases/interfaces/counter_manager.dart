import '../../../core/domain/result.dart';
import '../../../core/infrastructure/domain_error.dart';
import '../../counter.dart';

abstract class CounterManager {
  Future<Result<Counter, DomainError>> getCounter();
  Future<Result<Counter, DomainError>> saveCounter(int value);
}
