import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/counter_manager_impl.dart';
import '../infrastructure/counter_service_impl.dart';
import '../presentation/interfaces/counter_use_case.dart';
import '../usecases/counter_usecase_impl.dart';
import '../usecases/interfaces/counter_manager.dart';
import '../data/interfaces/counter_service.dart';

part 'counter_providers.g.dart';

@riverpod
CounterService counterService(CounterServiceRef ref) {
  return CounterServiceImpl();
}

@riverpod
CounterManager counterManager(CounterManagerRef ref) {
  final service = ref.watch(counterServiceProvider);
  return CounterManagerImpl(service);
}

@riverpod
CounterUseCase counterUseCase(CounterUseCaseRef ref) {
  final manager = ref.watch(counterManagerProvider);
  return CounterUseCaseImpl(manager);
}
