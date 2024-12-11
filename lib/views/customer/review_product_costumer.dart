import 'dart:io'; // Para manejar la imagen como un archivo
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sarti_mobile/widgets/customer/confirm_modal.dart';

class ReviewProductoCustomer extends StatefulWidget {
  @override
  _ReviewProductoCustomerState createState() => _ReviewProductoCustomerState();
}

class _ReviewProductoCustomerState extends State<ReviewProductoCustomer> {
  final TextEditingController opinionController = TextEditingController();
  int selectedRating = 0;
  final ImagePicker _picker = ImagePicker();
  File? _image; // Variable para almacenar la imagen seleccionada

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _image = File(photo.path); // Guardar la foto tomada
        });
        print('Foto tomada: ${_image?.path}');
      }
    } catch (e) {
      // Manejar errores como permisos o fallos en la cámara
      print('Error al tomar foto: $e');
    }
  }

  Future<void> _pickPhoto() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = File(image.path); // Guardar la imagen seleccionada
        });
        print('Foto seleccionada: ${_image?.path}');
      }
    } catch (e) {
      // Manejar errores como permisos o fallos en la galería
      print('Error al seleccionar foto: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear reseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "¿Qué calificación le pondrías?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  'assets/logo/ICON-SARTI.png',
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Paquete de Cake-Topper con Cupcakes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                alignment: WrapAlignment.center,
                children: List.generate(
                  10,
                  (index) => IconButton(
                    icon: Icon(
                      Icons.star,
                      color: index < selectedRating ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                "Tú opinión",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: opinionController,
                maxLength: 250,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Escribe tu opinión aquí...',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Añadir Fotos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _pickPhoto, // Lógica para seleccionar una foto desde la galería
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Subir"),
                  ),
                  ElevatedButton(
                    onPressed: _takePhoto, // Lógica para tomar una foto
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Tomar"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_image != null) 
                Column(
                  children: [
                    const Text(
                      "Vista previa de la imagen:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Image.file(_image!), // Mostrar la imagen tomada o seleccionada
                  ],
                ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final confirmed = await showDialog(
                      context: context,
                      builder: (context) => const ConfirmModal(
                        title: 'Confirmar Reseña',
                        description: '¿Estás seguro de enviar tu reseña?',
                        showImage: true, // Mostrar imagen al confirmar
                        imagePath: 'assets/customer/rese.png',
                      ),
                    );

                    if (confirmed == true) {
                      showDialog(
                        context: context,
                        builder: (context) => const ConfirmModal(
                          title: '¡Reseña Confirmada!',
                          description: 'Gracias por tu reseña.',
                          isFinal: true,
                          showImage: true,
                          imagePath: 'assets/customer/success.gif',
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
