import 'package:flutter/material.dart';
import 'package:sarti_mobile/views/auth/email_login_screen.dart'; // Asegúrate de que la ruta sea correcta

// Modal que se muestra cuando el usuario no está autenticado
void showLoginPromptModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("¿Deseas iniciar sesión?"),
        content: Text("Para comprar este producto, debes iniciar sesión."),
        actions: <Widget>[
          // Botón "Sí", que lleva al usuario a la pantalla de login
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmailLoginScreen()), // Aquí diriges al usuario al login
              );
            },
            child: Text("Sí"),
          ),
     
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el modal
            },
            child: Text("No"),
          ),
        ],
      );
    },
  );
}
