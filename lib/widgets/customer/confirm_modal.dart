import 'package:flutter/material.dart';

class ConfirmModal extends StatelessWidget {
  final String title;
  final String description;
  final bool isFinal;
  final bool showImage;
  final String? imagePath;

  const ConfirmModal({
    Key? key,
    required this.title,
    required this.description,
    this.isFinal = false,
    this.showImage = false,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showImage && imagePath != null)
            Image.asset(imagePath!, fit: BoxFit.contain),
          const SizedBox(height: 16),
          Text(description, textAlign: TextAlign.center),
        ],
      ),
      actions: isFinal
          ? [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Aceptar'),
              ),
            ]
          : [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Confirmar'),
              ),
            ],
    );
  }
}
