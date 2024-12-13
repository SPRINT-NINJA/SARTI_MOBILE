import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarti_mobile/viewmodels/sellers/seller_viewmodel.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/views/auth/product_list_screen.dart';
import 'package:sarti_mobile/views/auth/home_screen.dart';
import 'package:sarti_mobile/views/seller/sellers_products_list_view.dart'; // Importa la HomeScreen

class SellersListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SellersViewModel()..loadSellers(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              // Navega a HomeScreen al presionar el ícono de SARTI
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/logo/ICON-SARTI.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Emprendedores",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Consumer<SellersViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading && viewModel.sellers.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: viewModel.sellers.length + 1,
                    itemBuilder: (context, index) {
                      if (index == viewModel.sellers.length) {
                        return viewModel.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : const SizedBox.shrink();
                      }

                      final seller = viewModel.sellers[index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                seller.mainImage,
                                height: 100,
                                alignment: Alignment.center,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      seller.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      seller.description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SellersProductsListView(
                                                    sellerId: seller.id),
                                          ),
                                        );
                                      },
                                      child: const Text('Ver productos'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.sencudaryColor,
                                        foregroundColor: Colors.white,
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
