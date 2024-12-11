import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/create-account/seller',
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
    )
  ],
);
