import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/domain/result.dart';
import '../../../core/presentation/viewstate/view_state.dart';
import '../navigatorstates/login_navigator_state.dart';
import '../../di/login_providers.dart';
import 'login_state.dart';

part 'login_viewmodel.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() {
    return const LoginState();
  }

  void onEmailChanged(String value) {
    state = state.copyWith(email: value);
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(password: value);
  }

  Future<void> login() async {
    // Validate email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(state.email)) {
      state = state.copyWith(viewState: const ErrorState('Email inválido'));
      return;
    }

    // Validate password
    if (state.password.isEmpty) {
      state = state.copyWith(
        viewState: const ErrorState('Ingresá tu contraseña'),
      );
      return;
    }

    // Loading
    state = state.copyWith(viewState: const Loading());

    // Execute use case
    final useCase = ref.read(loginUseCaseProvider);
    final result = await useCase.invoke(state.email, state.password);

    state = switch (result) {
      Success() => state.copyWith(
        viewState: const Ready(),
        navigatorState: const GoToHomeScreen(),
      ),
      Failure(error: final uiError) => state.copyWith(
        viewState: ErrorState(uiError.message),
      ),
    };
  }

  void clearError() {
    state = state.copyWith(viewState: const Ready());
  }
}
