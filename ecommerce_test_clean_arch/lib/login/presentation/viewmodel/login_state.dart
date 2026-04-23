import '../../../core/presentation/viewstate/view_state.dart';
import '../navigatorstates/login_navigator_state.dart';

class LoginState {
  final String email;
  final String password;
  final ViewState<void> viewState;
  final LoginNavigatorState navigatorState;

  const LoginState({
    this.email = '',
    this.password = '',
    this.viewState = const Ready(),
    this.navigatorState = const NoNavigation(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    ViewState<void>? viewState,
    LoginNavigatorState? navigatorState,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      viewState: viewState ?? this.viewState,
      navigatorState: navigatorState ?? this.navigatorState,
    );
  }
}
