import '../../core/domain/result.dart';
import '../../core/infrastructure/domain_error.dart';
import '../usecases/interfaces/login_manager.dart';
import 'interfaces/login_service.dart';

class LoginManagerImpl implements LoginManager {
  final LoginService service;

  LoginManagerImpl(this.service);

  @override
  Future<Result<String, DomainError>> login(
    String email,
    String password,
  ) async {
    final result = await service.login(email, password);
    return switch (result) {
      Success(value: final token) => Success(token),
      Failure(error: final exception) => Failure(
        DomainError(exception.toString()),
      ),
    };
  }
}
