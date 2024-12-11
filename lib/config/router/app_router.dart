import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/views/views.dart';
import 'package:sarti_mobile/views/auth/create_account/create_account.dart';
import 'package:sarti_mobile/views/auth/email_login_screen.dart';
import 'package:sarti_mobile/views/auth/login_screen.dart';
import 'package:sarti_mobile/views/auth/validate_email_view.dart';
import 'package:sarti_mobile/views/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[

    //create account [delivery, customer, seller]
    GoRoute(
      path: '/create-account',
      builder: (BuildContext context, GoRouterState state) =>
      const WelcomeView(),
      routes: <RouteBase>[
        GoRoute(
          path: '/delivery',
          name: CreateAccountDeliveryView.name,
          builder: (context, GoRouterState state) =>
          const CreateAccountDeliveryView(),
        ),
        GoRoute(
          path: '/costumer',
          name: CreateAccountCustomerFormView.name,
          builder: (context, GoRouterState state) =>
          const CreateAccountCustomerFormView(),
        ),
        GoRoute(
          path: '/seller',
          name: CreateAccountSellerView.nameView,
          builder: (context, GoRouterState state) =>
          const CreateAccountSellerView(),
        ),

      ],
    ),



    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login-email',
      builder: (BuildContext context, GoRouterState state) =>
          EmailLoginScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => LoginScreen(),
    ),
    GoRoute(
      path: '/login-pwd',
      builder: (BuildContext context, GoRouterState state) =>
          PasswordLoginScreen(userEmail: ''),
    ),
    GoRoute(
      path: '/product-detail',
      builder: (BuildContext context, GoRouterState state) =>
          const ProductDetailScreen(
        imageUrl: '',
        title: '',
        price: 0,
        description: '',
      ),
    ),
    GoRoute(
      path: '/product-list',
      builder: (BuildContext context, GoRouterState state) =>
          ProductListScreen(),
    ),
    GoRoute(
      path: '/recovery-pwd',
      builder: (BuildContext context, GoRouterState state) =>
          RecoveryPasswordView(),
    ),
    GoRoute(
      path: '/top-rated',
      builder: (BuildContext context, GoRouterState state) => ProductosScreen(),
    ),
    GoRoute(
      path: '/validte-email',
      builder: (BuildContext context, GoRouterState state) =>
          ValidateEmailView(),
    ),
    GoRoute(
      path: '/tutorial',
      builder: (BuildContext context, GoRouterState state) =>
          const TutorialView(),
    ),

    GoRoute(
      path: '/login',
      name: EmailLoginScreen.name,// Optional name for the route, used for navigation
      builder: (BuildContext context, GoRouterState state) => EmailLoginScreen(),
    ),

    GoRoute(
      path: '/validate-email',
      name: ValidateEmailView.name,
      builder: (BuildContext context, GoRouterState state) => const ValidateEmailView(),
    ),

    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
    ),
  ],
);
