import '../../core/domain/result.dart';
import '../../core/infrastructure/domain_error.dart';
import '../counter.dart';
import 'interfaces/counter_service.dart';
import 'mappers/counter_mapper.dart';
import '../usecases/interfaces/counter_manager.dart';

class CounterManagerImpl implements CounterManager {
  final CounterService service;

  CounterManagerImpl(this.service);

  @override
  Future<Result<Counter, DomainError>> getCounter() async {
    try {
      final response = await service.getCounter();
      return Success(CounterMapper.fromResponse(response));
    } catch (e) {
      return Failure(DomainError(e.toString()));
    }
  }

  @override
  Future<Result<Counter, DomainError>> saveCounter(int value) async {
    try {
      final response = await service.saveCounter(value);
      return Success(CounterMapper.fromResponse(response));
    } catch (e) {
      return Failure(DomainError(e.toString()));
    }
  }
}
