import '../../../core/domain/result.dart';
import '../../../core/presentation/models/ui_error.dart';

abstract class LoginUseCase {
  Future<Result<String, UiError>> invoke(String email, String password);
}
