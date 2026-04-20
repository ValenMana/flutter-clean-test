import 'interfaces/counter_datasource.dart';
import 'mappers/counter_mapper.dart';
import '../domain/counter.dart';

class CounterRepositoryImpl {
  final ICounterDataSource _dataSource;

  CounterRepositoryImpl(this._dataSource);

  Future<Counter> getCounter() async {
    final response = await _dataSource.getCounter();
    return CounterMapper.fromResponse(response);
  }

  Future<Counter> incrementCounter(int currentValue) async {
    final response = await _dataSource.incrementCounter(currentValue);
    return CounterMapper.fromResponse(response);
  }
}
