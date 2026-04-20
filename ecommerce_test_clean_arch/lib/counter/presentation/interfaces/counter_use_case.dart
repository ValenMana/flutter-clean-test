import '../../domain/counter.dart';
import '../../data/counter_repository_impl.dart';

abstract class ICounterUseCase {
  Future<Counter> getCounter();
  Future<Counter> incrementCounter(int currentValue);
}

class CounterUseCaseImpl implements ICounterUseCase {
  final CounterRepositoryImpl _repository;

  CounterUseCaseImpl(this._repository);

  @override
  Future<Counter> getCounter() => _repository.getCounter();

  @override
  Future<Counter> incrementCounter(int currentValue) => _repository.incrementCounter(currentValue);
}
