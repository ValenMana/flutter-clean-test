import '../../../core/domain/result.dart';

abstract class LoginService {
  Future<Result<String, Exception>> login(String email, String password);
}
