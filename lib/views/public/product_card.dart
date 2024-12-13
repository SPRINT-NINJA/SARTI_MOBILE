import 'package:flutter/material.dart';
import 'package:sarti_mobile/models/product/product_model_public.dart';



class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ( product.mainImage != null  )_ImageViewer( images: product.mainImage ?? '' ),
        Text( product.name ?? '', textAlign: TextAlign.center, ),
        const SizedBox(height: 20)
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {

  final String images;

  const _ImageViewer({ required this.images });

  @override
  Widget build(BuildContext context) {

    if ( images.isEmpty ) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/no-image.jpg',
          fit: BoxFit.cover,
          height: 250,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage(
        fit: BoxFit.contain,
        height: 200,
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 200),
        image: NetworkImage( images ),
        placeholder: const AssetImage('assets/loaders/loader.gif'),
      ),
    );

  }
}