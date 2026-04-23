sealed class LoginNavigatorState {
  const LoginNavigatorState();
}

class NoNavigation extends LoginNavigatorState {
  const NoNavigation();
}

class GoToHomeScreen extends LoginNavigatorState {
  const GoToHomeScreen();
}
