import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/views/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const WelcomeView(),
      routes: <RouteBase>[
        GoRoute(
          path: 'create-account/:role',
          builder: (context, GoRouterState state) => CreateAccountView(
            role: state.pathParameters['role']
          ),
        ),
      ],
    ),
  ],
);

