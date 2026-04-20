import '../../infrastructure/entities/counter_response.dart';

abstract class ICounterDataSource {
  Future<CounterResponse> getCounter();
  Future<CounterResponse> incrementCounter(int currentValue);
}
