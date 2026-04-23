import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/interfaces/login_service.dart';
import '../data/login_manager_impl.dart';
import '../infrastructure/login_service_impl.dart';
import '../presentation/interfaces/login_use_case.dart';
import '../usecases/interfaces/login_manager.dart';
import '../usecases/login_usecase_impl.dart';

part 'login_providers.g.dart';

@riverpod
LoginService loginService(LoginServiceRef ref) {
  return LoginServiceImpl();
}

@riverpod
LoginManager loginManager(LoginManagerRef ref) {
  final service = ref.watch(loginServiceProvider);
  return LoginManagerImpl(service);
}

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  final manager = ref.watch(loginManagerProvider);
  return LoginUseCaseImpl(manager);
}
