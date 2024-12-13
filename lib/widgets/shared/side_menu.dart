import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/viewmodels/auth/auth_provider.dart';
import 'package:sarti_mobile/widgets/shared/custom_filled_button.dart';

class MenuItem  {
  final IconData? icon;
  final String label;
  final String link;

  MenuItem({required this.label, required this.icon, required this.link});
}

final menuItemsProvider = Provider<List<MenuItem>>((ref) {
  // Simula un usuario autenticado
  final state = ref.watch(authProvider);
  role? userRole = getRoleFromString(state.user!.role);

  final List<MenuItem> items = [];

  if (userRole == role.delivery) {
    return [
      MenuItem(label: 'Dashboard', icon: Icons.dashboard, link: '/dashboard'),
      MenuItem(label: 'Usuarios', icon: Icons.people, link: '/users'),
      MenuItem(label: 'Configuraciones', icon: Icons.settings, link: '/settings'),
    ];
  } else if (userRole == role.seller) {
    return [
      MenuItem(label: 'Productos', icon: Icons.shopping_bag, link: '/products'),
      MenuItem(label: 'Pedidos', icon: Icons.shopping_cart, link: '/orders'),
    ];
  }else if (userRole == role.customer) {
    return [
      MenuItem(label: 'Productos', icon: Icons.shopping_bag, link: '/home'),
      MenuItem(label: 'Emprendedores', icon: Icons.shopping_bag, link: '/sellers/list'),
      MenuItem(label: 'Mejores calificados', icon: Icons.shopping_cart, link: '/rated/top'),
      MenuItem(label: 'Carrito', icon: Icons.shopping_cart, link: '/shopping-cart'),
      MenuItem(label: 'Perfil', icon: Icons.shopping_cart, link: '/shopping-cart'),
    ];
  }
  return items;
});



class SideMenu extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;


  const SideMenu({
    super.key,
    required this.scaffoldKey
  });

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {

  int navDrawerIndex = 0; // Índice por defecto seleccionado


  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    // Obtén los items del menú desde el provider
    final menuItems = ref.watch(menuItemsProvider);

    return NavigationDrawer(
      elevation: 1,
      selectedIndex:  navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        final menuItem = menuItems[value];
        context.push(menuItem.link);
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
          child: Text('Que gusto verte!', style: textStyles.titleMedium),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
          child: Text(ref.watch(authProvider).user?.email ?? '', style: textStyles.titleSmall),
        ),
        ...menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.label),
          );
        }).toList(),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Otras opciones'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            onPressed: () {
              //confirm logout
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Cerrar sesión'),
                    content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(authProvider.notifier).logout();
                          context.push('/');
                        },
                        child: const Text('Cerrar sesión'),
                      ),
                    ],
                  );
                },
              );
            },
            text: 'Cerrar sesión',
          ),
        ),
      ],
    );
  }

}