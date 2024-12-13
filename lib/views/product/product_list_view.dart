import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarti_mobile/viewmodels/product/product_list_view_model.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductListViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create-product');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar producto',
                border: OutlineInputBorder(),
              ),
              onChanged: viewModel.setSearchQuery,
            ),
          ),
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: viewModel.products.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.products[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(product.mainImage),
                          ),
                          title: Text(product.name),
                          subtitle: Text(
                            '\$${product.price.toStringAsFixed(2)} • Stock: ${product.stock}',
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                Navigator.pushNamed(
                                  context,
                                  '/edit-product',
                                  arguments: product.id,
                                );
                              } else if (value == 'delete') {
                                viewModel.deleteProduct(product.id);
                              } else if (value == 'status') {
                                viewModel.changeProductStatus(product.id);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Editar'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Eliminar'),
                              ),
                              PopupMenuItem(
                                value: 'status',
                                child: Text(
                                  product.status ? 'Desactivar' : 'Activar',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (viewModel.hasMore)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: viewModel.loadMoreProducts,
                child: const Text('Cargar más'),
              ),
            ),
        ],
      ),
    );
  }
}
