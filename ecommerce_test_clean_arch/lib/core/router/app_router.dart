import 'package:go_router/go_router.dart';
import '../../login/presentation/screens/login_screen.dart';
import '../../counter/presentation/screens/counter_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/counter',
      name: 'counter',
      builder: (context, state) => const CounterScreen(),
    ),
  ],
);
