import 'package:flutter/material.dart';

class ProductCreateViewModel extends ChangeNotifier {
  // TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Imagen principal
  dynamic mainImage; // Esto debería ser un archivo de tipo File
  List<dynamic> additionalImages =
      []; // Esto también debería ser una lista de archivos tipo File

  // Métodos para configurar los datos
  void setName(String name) {
    nameController.text = name;
    notifyListeners();
  }

  void setPrice(double price) {
    priceController.text = price.toString();
    notifyListeners();
  }

  void setStock(int stock) {
    stockController.text = stock.toString();
    notifyListeners();
  }

  void setDescription(String description) {
    descriptionController.text = description;
    notifyListeners();
  }

  Future<void> pickMainImage() async {
    // Lógica para seleccionar una imagen principal
    notifyListeners();
  }

  Future<void> pickAdditionalImages() async {
    // Lógica para seleccionar imágenes adicionales
    notifyListeners();
  }

  Future<void> createProduct() async {
    // Lógica para crear el producto
    print('Producto creado: ${nameController.text}');
  }

  @override
  void dispose() {
    // Limpiar los controladores para liberar memoria
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
