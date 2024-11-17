import 'package:flutter/material.dart';
import 'package:sarti_mobile/utils/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  final List<String> additionalImages;

  const ProductDetailScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.additionalImages = const [
      'assets/logo/ICON_SARTI.png', // Primera imagen adicional
      'assets/logo/ICON_SARTI.png', // Segunda imagen adicional
      'assets/logo/ICON_SARTI.png', // Tercera imagen adicional
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título del producto
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Imagen principal del producto
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GestureDetector(
                    onTap: () {
                      _showFullImage(context, imageUrl);
                    },
                    child: Image.asset(
                      imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),

              // Galería de imágenes adicionales
              if (additionalImages.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: additionalImages.map((imgUrl) {
                    return GestureDetector(
                      onTap: () {
                        _showFullImage(context, imgUrl);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(imgUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              SizedBox(height: 16),

              // Rating y precio
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 24),
                      SizedBox(width: 4),
                      Text(
                        "10",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " (+50 disponibles)",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Text(
                    '\$$price',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Row(
                children: [
                  Text(
                    'Cantidad: ',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  Text(
                    '1 unidad ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Descripción
              Text(
                "Lo que tienes que saber del producto:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Comprar ahora',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        );
      },
    );
  }
}
