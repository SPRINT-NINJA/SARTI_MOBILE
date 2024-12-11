import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  final String message;
  final IconData? icon;

  const FullScreenLoader({
    super.key,
    this.message = 'Cargando...',
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFD8B8),
              Color(0xFFFFEBD3),
              Color(0xFFFDF8F3),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)
                  ),
                ),
                Icon(
                  icon ?? Icons.hourglass_empty,
                  size: 40,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                color: Color(0xFFFAB76A),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
