import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/widgets/shared/custom_filled_button.dart';

class MenuItem {
  final IconData? icon;
  final String label;
  final String link;
  MenuItem({required this.label, required this.icon, required this.link});
}

var listOptions = <MenuItem>[
  MenuItem(label: 'Productos', icon: Icons.shopping_bag, link: '/'),
  MenuItem(label: 'Emprendedor', icon: Icons.shopping_bag, link: '/sellers-list'),
  MenuItem(label: 'Mejores calificados', icon: Icons.shopping_cart, link: '/rated-top'),
  MenuItem(label: 'Comenzar sesión', icon: Icons.shopping_cart, link: '/auth'),
];

class PublicSideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const PublicSideMenu({
    super.key,
    required this.scaffoldKey,
  });

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<PublicSideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
        final menuItem = listOptions[value];
        context.push(menuItem.link);
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 30, 16, 0),
          child: Text('Bienvenido a SARTI!', style: textStyles.titleLarge),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 5, 10),
          child: Text('Inicia sesión o crea una cuenta para comenzar a comprar', style: textStyles.titleSmall?.copyWith(color: Colors.grey)),
        ),
        // Elementos de navegación de arriba (productos, emprendedor, etc.)
        ...listOptions.sublist(0, listOptions.length - 1).map((item) {
          return NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.label),
          );
        }),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        // Botón inferior para la acción de "Comenzar sesión"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            onPressed: () {
              final item = listOptions.last; // El último ítem en la lista
              context.push(item.link);
            },
            text: listOptions.last.label, // Usamos el label del último ítem
          ),
        ),
      ],
    );
  }
}
