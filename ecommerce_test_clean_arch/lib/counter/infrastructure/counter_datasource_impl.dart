import '../data/interfaces/counter_datasource.dart';
import 'entities/counter_response.dart';

class CounterDataSourceImpl implements ICounterDataSource {
  @override
  Future<CounterResponse> getCounter() async {
    // Simulating API call
    return CounterResponse(count: 0);
  }

  @override
  Future<CounterResponse> incrementCounter(int currentValue) async {
    // Simulating API call
    return CounterResponse(count: currentValue + 1);
  }
}
