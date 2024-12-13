import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/viewmodels/product/product_viewmodel.dart';
import 'package:sarti_mobile/views/auth/product_details_screen.dart';

class TopRatedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text('Top Rated Products'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Encabezado
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top Rated Products',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Consumer<ProductViewModel>(
                        builder: (context, viewModel, _) {
                          return DropdownButton<String>(
                            dropdownColor: AppColors.primaryColor,
                            value: viewModel.sortDirection,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                viewModel.sortDirection = newValue;
                                viewModel.fetchProducts(reset: true);
                              }
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'desc',
                                child: Text(
                                  'Mayor a menor',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'asc',
                                child: Text(
                                  'Menor a mayor',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                            icon: const Icon(Icons.sort, color: Colors.black),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // GridView dentro de un contenedor con altura fija
                Consumer<ProductViewModel>(
                  builder: (context, viewModel, _) {
                    if (viewModel.isLoading && viewModel.products.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (viewModel.error != null) {
                      return Center(child: Text(viewModel.error!));
                    }

                    if (viewModel.products.isEmpty) {
                      return const Center(child: Text('No hay productos disponibles.'));
                    }

                    final paginatedProducts = viewModel.products;

                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7, // Ajusta la altura
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: paginatedProducts.length,
                        itemBuilder: (context, index) {
                          final product = paginatedProducts[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    id: product.id.toString(),
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                    child: Image.network(
                                      product.mainImage,
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.orangeAccent, size: 16),
                                            const SizedBox(width: 5),
                                            Text(
                                              product.rating.toStringAsFixed(1),
                                              style:
                                                  const TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                // Paginación
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          final viewModel = Provider.of<ProductViewModel>(context,
                              listen: false);
                          if (viewModel.currentPage > 0) {
                            viewModel.currentPage--;
                            viewModel.fetchProducts(reset: true);
                          }
                        },
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Consumer<ProductViewModel>(
                        builder: (context, viewModel, _) {
                          return Text('Página ${viewModel.currentPage + 1}');
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          final viewModel = Provider.of<ProductViewModel>(context,
                              listen: false);
                          if (viewModel.products.length == viewModel.pageSize) {
                            viewModel.currentPage++;
                            viewModel.fetchProducts(reset: true);
                          }
                        },
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
