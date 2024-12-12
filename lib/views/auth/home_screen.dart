import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sarti_mobile/config/router/app_router.dart';
import 'package:sarti_mobile/services/auth_service.dart';
import 'package:sarti_mobile/viewmodels/product/product_viewmodel.dart';
import 'package:sarti_mobile/views/auth/product_details_screen.dart';
import 'package:sarti_mobile/views/auth/top_rated.dart';
import 'package:sarti_mobile/views/customer/shopping_scree.dart';
import 'package:sarti_mobile/views/sellers/sellers_list_view.dart';
import 'package:sarti_mobile/views/views.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importar la vista de emprendedores

class HomeScreen extends StatelessWidget {

  static const name = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AuthService _authService = AuthService();


    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final prefs = snapshot.data;
          return ChangeNotifierProvider(
            create: (_) => ProductViewModel()..fetchProducts(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: theme.primaryColor,
                elevation: 0,
                automaticallyImplyLeading: prefs?.getString('token') == null,
                actions: [
                  if (prefs?.getString('token') != null)
                    IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {
                        // Carrito
                        context.pushNamed(ShoppingCartScreen.name);
                      },
                    ),

                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      _authService.logout();
                      context.pushNamed(WelcomeView.name);
                    },
                  ),
                ],
              ),
              // ... rest of your Scaffold
              body: Consumer<ProductViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading && viewModel.products.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (viewModel.error != null) {
                    return Center(child: Text(viewModel.error!));
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          color: theme.primaryColor,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Los mejores productos están aquí',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Cards de botones
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildFeatureCard(
                                icon: Icons.store,
                                title: 'Emprendedor',
                                theme: theme,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SellersListView(),
                                    ),
                                  );
                                },
                              ),
                              _buildFeatureCard(
                                icon: Icons.star,
                                title: 'Mejores calificados',
                                theme: theme,
                                onTap: () {
                                  context.pushNamed(ProductosScreen.name);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Te va a encantar',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Listado de productos
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: viewModel.products.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
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
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: product.mainImage,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  size: 14, color: Colors.orange),
                                              const SizedBox(width: 4),
                                              Text(
                                                product.rating > 0
                                                    ? product.rating
                                                    .toStringAsFixed(1)
                                                    : '0.0',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
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
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator(); // Or a loading indicator
        }
      },
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required ThemeData theme,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: theme.colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 40, color: theme.primaryColor),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
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
