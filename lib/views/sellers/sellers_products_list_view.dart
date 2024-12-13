import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarti_mobile/viewmodels/product/provider.dart';
import 'package:sarti_mobile/models/product/product_model_public.dart';
import 'package:sarti_mobile/views/auth/product_details_screen.dart';

class SellersProductsListView extends ConsumerStatefulWidget {
  final int sellerId;

  const SellersProductsListView({required this.sellerId});

  @override
  _SellersProductsListViewState createState() =>
      _SellersProductsListViewState();
}

class _SellersProductsListViewState
    extends ConsumerState<SellersProductsListView> {
  @override
  void initState() {
    super.initState();

    // Llama al método de carga después de que el widget se haya inicializado
    Future.microtask(() {
      ref.read(productViewModelProvider.notifier).fetchProductsForSeller(
            sellerId: widget.sellerId,
            reset: true,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = ref.watch(productViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Productos del Vendedor ${widget.sellerId}')),
      body: productViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productViewModel.products.isEmpty
              ? const Center(child: Text('No hay productos disponibles.'))
              : GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Dos columnas
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7, // Proporción ancho:alto
                  ),
                  itemCount: productViewModel.products.length,
                  itemBuilder: (context, index) {
                    final product = productViewModel.products[index];
                    return ProductCard(product: product);
                  },
                ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navega a ProductDetailsScreen con la información del producto
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              title: product.name,
              imageUrl: product.mainImage,
              price: product.price,
              description: product.description,
              additionalImages: product.productImages,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                product.mainImage,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Detalles del producto
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
