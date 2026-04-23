import '../data/interfaces/counter_service.dart';
import 'entities/counter_response.dart';

class CounterServiceImpl implements CounterService {
  @override
  Future<CounterResponse> getCounter() async {
    return CounterResponse(count: 0);
  }

  @override
  Future<CounterResponse> saveCounter(int value) async {
    // Simulating saving the value
    return CounterResponse(count: value);
  }
}
