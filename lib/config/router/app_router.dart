import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/views/auth/create_account/create_account.dart';
import 'package:sarti_mobile/views/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/create-account/delivery',
  routes: <RouteBase>[

    GoRoute(
      path: '/create-account',
      builder: (BuildContext context, GoRouterState state) => const WelcomeView(),
      routes: <RouteBase>[
        GoRoute(
          path: '/delivery',
          name: CreateAccountDeliveryView.name,
          builder: (context, GoRouterState state) => const CreateAccountDeliveryView(),
        ),
        GoRoute(
          path: '/costumer',
          name: CreateAccountDeliveryView.name,
          builder: (context, GoRouterState state) => const CreateAccountDeliveryView(),
        ),
      ],
    ),
    
        
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

