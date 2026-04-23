import '../../counter.dart';
import '../../infrastructure/entities/counter_response.dart';

class CounterMapper {
  static Counter fromResponse(CounterResponse response) {
    return Counter(value: response.count);
  }
}
