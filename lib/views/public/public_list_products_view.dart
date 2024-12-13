
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/viewmodels/product/product_provider.dart';
import 'package:sarti_mobile/views/auth/top_rated.dart';
import 'package:sarti_mobile/views/public/product_card.dart';
import 'package:sarti_mobile/views/seller/sellers_list_view.dart';
import 'package:sarti_mobile/views/views.dart';
import 'package:sarti_mobile/widgets/public/public_side_menu.dart';

class PublicListProductsView extends StatelessWidget {
  static const name = 'public-list-products';

  const PublicListProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: PublicSideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              context.go('/');
            },
            child: Image.asset(
              'assets/images/logo_sarti_leading.png',
              width: size.width * 0.2,
              height: 40,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Text(
              'Los mejores productos están aquí',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopRatedScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Te va a encantar',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 16),

          const _Cards(),
        ],
      ),
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

class _Cards extends ConsumerStatefulWidget {
  const _Cards();

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends ConsumerState<_Cards> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ( (scrollController.position.pixels + 400) >= scrollController.position.maxScrollExtent ) {
        // Cargar más productos
        print('Cargar más productos');
      }
    });

    @override
    void dispose() {
      scrollController.dispose();
      super.dispose();
    }


  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch( getSellProductsProvider);

    return products.when(
      data: (products) {
       return Expanded(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: MasonryGridView.count(
             crossAxisCount: 2,
             mainAxisSpacing: 20,
             crossAxisSpacing: 35,
             itemCount: products.length,
             itemBuilder: (context, index) {
               final product = products[index];
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
                 child: ProductCard(product: product ),
               );
             },
           ),
         ),
       );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
