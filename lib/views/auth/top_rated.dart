import 'package:flutter/material.dart';
import 'package:sarti_mobile/utils/colors.dart';

class Producto {
  final String nombre;
  final String imagen;
  final double precio;
  final double calificacion;

  Producto({
    required this.nombre,
    required this.imagen,
    required this.precio,
    required this.calificacion,
  });
}

class ProductosScreen extends StatelessWidget {
  final List<Producto> productos = [
    Producto(
        nombre: 'Pulsera de bob y patricio estrella',
        imagen: 'assets/logo/ICON-SARTI.png',
        precio: 57.90,
        calificacion: 4.5),
    Producto(
        nombre: 'Juego de vajilla pintada a mano',
        imagen: 'assets/logo/ICON-SARTI.png',
        precio: 30000,
        calificacion: 5.0),
    Producto(
        nombre: 'Otro producto',
        imagen: 'assets/logo/ICON-SARTI.png',
        precio: 57.90,
        calificacion: 4.2),
    Producto(
        nombre: 'Otro producto 2',
        imagen: 'assets/logo/ICON-SARTI.png',
        precio: 57.90,
        calificacion: 3.8),
    // Agrega más productos según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Tarjeta destacada (primer producto)
            FeaturedProductCard(
                producto: productos[
                    1]), // Cambia el índice según el producto que quieras destacar
            SizedBox(height: 10),

            // GridView para los productos
            GridView.builder(
              physics:
                  NeverScrollableScrollPhysics(), // Evita que el GridView se desplace de manera independiente
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7, // Ajusta el aspecto de la tarjeta
              ),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                if (index == 1)
                  return Container(); // Omitir el producto destacado en el GridView
                return ProductCard(producto: productos[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedProductCard extends StatelessWidget {
  final Producto producto;

  const FeaturedProductCard({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(producto.imagen),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producto.nombre,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "\$${producto.precio.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: index < producto.calificacion
                          ? Colors.amber
                          : Colors.white,
                      size: 18,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Producto producto;

  const ProductCard({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              producto.imagen,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producto.nombre,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "\$${producto.precio.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Spacer(),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: index < producto.calificacion
                              ? Colors.amber
                              : Colors.grey,
                          size: 14,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
