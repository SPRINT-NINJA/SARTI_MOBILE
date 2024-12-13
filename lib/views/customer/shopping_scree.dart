import 'package:flutter/material.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/models/cart_model.dart';
import 'package:sarti_mobile/services/cart/cart_service.dart';

class ShoppingCartScreen extends StatefulWidget {
  static const name = 'shopping-cart';

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final CartService cartService = CartService();
  List<CartItem> items = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCart();
  }

  Future<void> _fetchCart() async {
    try {
      final cartData = await cartService.getCart();
      setState(() {
        items = cartData.cartProducts!.map((cart) => CartItem(
          id: cart.product?.id ?? 0,
          cartProductId: cart.id,
          name: cart.product?.name ?? 'Producto sin nombre',
          imageUrl: cart.product?.mainImage ?? 'https://via.placeholder.com/150',
          price: cart.product?.price ?? 0.0,
          quantity: cart.amount,
          isAvailable: cart.product?.status ?? false,
        )).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error al cargar el carrito: $e';
      });
    }
  }

  void _updateQuantity(int index, int delta) async {
    final newQuantity = items[index].quantity + delta;
    if (newQuantity >= 1) {
      var response = await cartService.updateProductQuantity(items[index].id, newQuantity);
      if (response) {
        _fetchCart();
      }
    }
  }

  void _deleteProduct(int index) async {
    var response = await cartService.deleteProductFromCart(items[index].cartProductId);
    if (response) {
      _fetchCart();
    }
  }

  void _clearCart() async {
    var response = await cartService.cleanCart();
    if (response) {
      _fetchCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice =
    items.fold(0, (sum, item) => sum + item.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tu carrito'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _clearCart,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(item.imageUrl, width: 80, height: 80, errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 80)),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text('Cantidad:'),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    onPressed: () => _updateQuantity(index, -1),
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add_circle,
                                        color: Colors.green),
                                    onPressed: () => _updateQuantity(index, 1),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    item.isAvailable
                                        ? 'Disponible'
                                        : 'No Disponible',
                                    style: TextStyle(
                                      color: item.isAvailable
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$${item.price.toStringAsFixed(2)}',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            _deleteProduct(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Productos', style: TextStyle(fontSize: 16)),
                Text('\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                if (items.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('El carrito está vacío'),
                  ));
                  return;
                }
                if (items.any((item) => !item.isAvailable)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Algunos productos no están disponibles'),
                  ));
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Continuar con la compra en la web'),
                ));
              },
              child: Text('Continuar Compra', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final int id;
  final int cartProductId;
  final String name;
  final String imageUrl;
  final double price;
  late final int quantity;
  final bool isAvailable;

  CartItem({
    required this.id,
    required this.cartProductId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.isAvailable,
  });
}
