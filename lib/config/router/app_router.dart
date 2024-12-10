import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/views/auth/create_account/create_account.dart';
import 'package:sarti_mobile/views/auth/email_login_screen.dart';
import 'package:sarti_mobile/views/auth/login_screen.dart';
import 'package:sarti_mobile/views/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
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
          name: CreateAccountCustomerFormView.name,
          builder: (context, GoRouterState state) => const CreateAccountCustomerFormView(),
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
    ),

    GoRoute(
      path: '/login',
      name: EmailLoginScreen.name,// Optional name for the route, used for navigation
      builder: (BuildContext context, GoRouterState state) => EmailLoginScreen(),
    ),

    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
    ),
  ],
);

