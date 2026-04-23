import '../../core/domain/result.dart';
import '../../core/presentation/models/ui_error.dart';
import '../presentation/interfaces/login_use_case.dart';
import 'interfaces/login_manager.dart';

class LoginUseCaseImpl implements LoginUseCase {
  final LoginManager manager;

  LoginUseCaseImpl(this.manager);

  @override
  Future<Result<String, UiError>> invoke(String email, String password) async {
    final result = await manager.login(email, password);
    return switch (result) {
      Success(value: final token) => Success(token),
      Failure(error: final domainError) => Failure(
        UiError(domainError.message),
      ),
    };
  }
}
