import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarti_mobile/viewmodels/product/product_create_view_model.dart';

class ProductCreateView extends StatelessWidget {
  static const String name = 'create-product';

  const ProductCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductCreateViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Producto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: viewModel.nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre(s)',
                border: OutlineInputBorder(),
              ),
              onChanged: viewModel.setName,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: viewModel.priceController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                viewModel.setPrice(double.tryParse(value) ?? 0.0);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: viewModel.stockController,
              decoration: const InputDecoration(
                labelText: 'Stock',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                viewModel.setStock(int.tryParse(value) ?? 0);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: viewModel.descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: viewModel.setDescription,
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: viewModel.pickMainImage,
              icon: const Icon(Icons.image),
              label: const Text('Seleccionar foto principal'),
            ),
            if (viewModel.mainImage != null)
              Image.file(
                viewModel.mainImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: viewModel.pickAdditionalImages,
              icon: const Icon(Icons.photo_library),
              label: const Text('Seleccionar imágenes adicionales'),
            ),
            if (viewModel.additionalImages.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.additionalImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.file(
                        viewModel.additionalImages[index],
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await viewModel.createProduct();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Producto creado exitosamente'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
