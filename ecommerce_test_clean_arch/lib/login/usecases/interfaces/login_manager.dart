import '../../../core/domain/result.dart';
import '../../../core/infrastructure/domain_error.dart';

abstract class LoginManager {
  Future<Result<String, DomainError>> login(String email, String password);
}
