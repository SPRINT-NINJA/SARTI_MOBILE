import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/views/customer/shopping_scree.dart';
import 'package:sarti_mobile/views/delivery/delivery_orders_list.dart';
import 'package:sarti_mobile/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: WelcomeView.name,
      builder: (BuildContext context, GoRouterState state) =>
          const WelcomeView(),
    ),

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
      path: '/login-email',
      name: EmailLoginScreen.name,
      builder: (BuildContext context, GoRouterState state) =>
          EmailLoginScreen(),
    ),
    GoRoute(
      path: '/login-pwd',
      name: PasswordLoginScreen.name,
      builder: (BuildContext context, GoRouterState state) =>
          PasswordLoginScreen(userEmail: '', userName: ''),
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
          const RecoveryPasswordView(userEmail: ''),
    ),
    GoRoute(
      path: '/top-rated',
      name: ProductosScreen.name,
      builder: (BuildContext context, GoRouterState state) => ProductosScreen(),
    ),
    GoRoute(
      path: '/validte-email',
      builder: (BuildContext context, GoRouterState state) =>
          const ValidateEmailView(),
    ),
    GoRoute(
      path: '/tutorial',
      builder: (BuildContext context, GoRouterState state) =>
          const TutorialView(),
    ),

    GoRoute(
      path: '/validate-email',
      name: ValidateEmailView.name,
      builder: (BuildContext context, GoRouterState state) =>
          const ValidateEmailView(),
    ),

    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),

    GoRoute(path: '/home-delivery',
        name: DeliveryOrdersList.name,
        builder: (BuildContext context, GoRouterState state) =>
            DeliveryOrdersList()
    ),


    GoRoute(
      path: '/shopping-cart',
      name: ShoppingCartScreen.name,
      builder: (BuildContext context, GoRouterState state) =>
          ShoppingCartScreen(),
    )
  ],
);
