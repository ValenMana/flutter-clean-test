import '../../infrastructure/entities/counter_response.dart';

abstract class CounterService {
  Future<CounterResponse> getCounter();
  Future<CounterResponse> saveCounter(int value);
}
