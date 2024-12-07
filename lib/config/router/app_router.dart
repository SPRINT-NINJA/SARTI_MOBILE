import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/views/screens.dart';

import '../constant/enums.dart';

final appRouter = GoRouter(
  initialLocation: '/create-account/${ERoles.delivery}',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const WelcomeView(),
      routes: <RouteBase>[
        GoRoute(
          path: 'create-account/:role',
          name: CreateAccountView.name,
          builder: (context, GoRouterState state) => CreateAccountView(
            role: state.pathParameters['role']
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/tutorial',
      builder: (BuildContext context, GoRouterState state) => const TutorialView(),
    )
  ],
);

