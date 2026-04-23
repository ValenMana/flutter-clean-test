import '../data/interfaces/login_service.dart';
import '../../core/domain/result.dart';

class LoginServiceImpl implements LoginService {
  // Hardcoded credentials for testing
  static const _validEmail = 'admin@test.com';
  static const _validPassword = '123456';

  @override
  Future<Result<String, Exception>> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (email == _validEmail && password == _validPassword) {
      return const Success('fake-jwt-token-abc123');
    } else {
      return Failure(Exception('Credenciales inválidas'));
    }
  }
}
