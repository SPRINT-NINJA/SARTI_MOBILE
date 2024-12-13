import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/viewmodels/auth/auth_provider.dart';
import 'package:sarti_mobile/views/customer/shopping_scree.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarti_mobile/views/delivery/delivery_orders_list.dart';
import 'package:sarti_mobile/views/public/public_list_products_view.dart';
import 'package:sarti_mobile/views/seller/sellers_list_view.dart';
import 'package:sarti_mobile/views/views.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final role = ref.watch(authProvider).authStatus;

  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      // Rutas públicas
      GoRoute(
        path: '/',
        name: 'public',
        builder: (BuildContext context, GoRouterState state) =>
            const PublicListProductsView(),
      ),
      GoRoute(
        path: '/home',
        name: HomeScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: '/sellers-list',
        builder: (BuildContext context, GoRouterState state) =>
            SellersListView(),
      ),
      GoRoute(
        path: '/rated-top',
        builder: (BuildContext context, GoRouterState state) =>
            TopRatedScreen(),
      ),
      GoRoute(
        path: '/product/{id}',
        builder: (BuildContext context, GoRouterState state) =>
            const ProductDetailScreen(
          imageUrl: '',
          title: '',
          price: 0,
          description: '',
        ),
      ),
      GoRoute(
        path: '/product',
        builder: (BuildContext context, GoRouterState state) =>
            ProductListScreen(),
      ),
      GoRoute(
        path: '/recovery-pwd',
        builder: (BuildContext context, GoRouterState state) =>
            const RecoveryPasswordView(userEmail: ''),
      ),
      GoRoute(
        path: '/rate',
        builder: (BuildContext context, GoRouterState state) =>
            TopRatedScreen(),
      ),
      GoRoute(
        path: '/validate-email',
        name: ValidateEmailView.name,
        builder: (BuildContext context, GoRouterState state) =>
            const ValidateEmailView(),
      ),
      GoRoute(
        path: '/tutorial',
        builder: (BuildContext context, GoRouterState state) =>
            const TutorialView(),
      ),
      GoRoute(
        path: '/home-delivery',
        name: DeliveryOrdersList.name,
        builder: (BuildContext context, GoRouterState state) =>
            DeliveryOrdersList(),
      ),
      GoRoute(
        path: '/shopping-cart',
        name: ShoppingCartScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            ShoppingCartScreen(),
      ),

      // Rutas de autenticación
      GoRoute(
        path: '/auth',
        name: WelcomeView.name,
        builder: (BuildContext context, GoRouterState state) =>
            const WelcomeView(),
        routes: <RouteBase>[
          GoRoute(
            path: 'delivery',
            name: CreateAccountDeliveryView.name,
            builder: (context, GoRouterState state) =>
                const CreateAccountDeliveryView(),
          ),
          GoRoute(
            path: 'customer',
            name: CreateAccountCustomerFormView.name,
            builder: (context, GoRouterState state) =>
                const CreateAccountCustomerFormView(),
          ),
          GoRoute(
            path: 'seller',
            name: CreateAccountSellerView.nameView,
            builder: (context, GoRouterState state) =>
                const CreateAccountSellerView(),
          ),
        ],
      ),

      // Rutas de login
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
    ],
    redirect: (context, state) {
      const pathPublic = [
        '/',
        '/login-email',
        '/login-pwd',
        '/create-account',
        '/validate-email',
        '/recovery-pwd',
        '/tutorial',
        '/sellers-list',
        '/rated-top',
        '/auth/delivery',
        '/auth/customer',
        '/auth/seller',
        '/auth'
      ];
      final isGoingTo = state.fullPath;

      if (role == AuthStatus.notAuthenticated) {
        if (pathPublic.contains(isGoingTo)) {
          return null;
        }
        return '/'; // Si no está autenticado, redirige a la pantalla pública
      }

      if (role == AuthStatus.authenticated) {
        if (isGoingTo == '/') {
          return '/home'; // Si está autenticado, redirige al home
        }
        return null; // Si ya está en una ruta que puede acceder, no redirige
      }

      return null;
    },
  );
});
