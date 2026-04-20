import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/counter.dart';
import '../infrastructure/counter_datasource_impl.dart';
import '../data/counter_repository_impl.dart';
import '../presentation/interfaces/counter_use_case.dart';

part 'counter_providers.g.dart';

@riverpod
CounterRepositoryImpl counterRepository(CounterRepositoryRef ref) {
  final dataSource = CounterDataSourceImpl();
  return CounterRepositoryImpl(dataSource);
}

@riverpod
ICounterUseCase counterUseCase(CounterUseCaseRef ref) {
  final repository = ref.watch(counterRepositoryProvider);
  return CounterUseCaseImpl(repository);
}

@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  Future<Counter> build() async {
    final useCase = ref.watch(counterUseCaseProvider);
    return useCase.getCounter();
  }

  Future<void> increment(int currentValue) async {
    state = const AsyncLoading();
    final useCase = ref.read(counterUseCaseProvider);
    state = await AsyncValue.guard(() => useCase.incrementCounter(currentValue));
  }
}
