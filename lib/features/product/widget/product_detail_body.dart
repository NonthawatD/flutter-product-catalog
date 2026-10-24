import 'package:flutter/material.dart';
import 'package:product_catalog_application/features/product/models/product_model.dart';
import 'package:product_catalog_application/features/product/widget/product_gallery.dart';
import 'package:product_catalog_application/features/product/widget/product_info_section.dart';

class ProductDetailBody extends StatelessWidget {
  const ProductDetailBody({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 600;
    final images = product.images.isNotEmpty ? product.images : [product.thumbnail];

    final gallery = ProductGallery(images: images);
    final info = ProductInfoSection(product: product);

    return SingleChildScrollView(
      padding: EdgeInsets.all(isTablet ? 32 : 16),
      child: isTablet
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                SizedBox(width: 380, child: gallery),
                Expanded(child: info),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [gallery, info],
            ),
    );
  }
}