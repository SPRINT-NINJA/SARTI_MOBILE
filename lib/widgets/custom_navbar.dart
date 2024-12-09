import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomNavbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          // Acción del menú
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Image.asset(
            'assets/logo/ICON-SARTI.png',
            height: 40,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
