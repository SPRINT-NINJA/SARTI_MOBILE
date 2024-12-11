import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/viewmodels/product/product_viewmodel.dart';
import 'package:sarti_mobile/views/auth/product_details_screen.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                // Lógica para el carrito
              },
            ),
          ],
        ),
        body: Consumer<ProductViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading && viewModel.products.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.error != null) {
              return Center(child: Text(viewModel.error!));
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  viewModel.currentPage++;
                  viewModel.fetchProducts();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: viewModel.products.length,
                itemBuilder: (context, index) {
                  final product = viewModel.products[index];
                  return GestureDetector(
                    onTap: () {
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
                    child: ListTile(
                      leading: Image.network(product.mainImage),
                      title: Text(product.name),
                      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
