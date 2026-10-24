import 'package:flutter/material.dart';
import 'package:product_catalog_application/configs/app_theme.dart';
import 'package:product_catalog_application/features/product/models/product_model.dart';
import 'package:product_catalog_application/utils/context_extension.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final chips = [
      product.category,
      product.brand,
    ].where((e) => e.isNotEmpty).toList();
    final inStock = product.stock > 0;
    final stockColor = inStock ? AppColors.success : context.themeColor.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        if (chips.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final label in chips) _InfoChip(label: label)],
          ),
        Text(
          product.title,
          style: context.textTheme.headlineSmall?.copyWith(fontSize: 22),
        ),
        Row(
          spacing: 4,
          children: [
            const Icon(Icons.star_rounded, size: 20, color: AppColors.star),
            Text(
              product.rating.toStringAsFixed(2),
              style: context.textTheme.titleSmall,
            ),
          ],
        ),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: context.textTheme.titleMedium?.copyWith(fontSize: 30),
        ),
        Row(
          spacing: 6,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: stockColor,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              inStock ? 'มีสินค้า ${product.stock} ชิ้น' : 'สินค้าหมด',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: stockColor,
              ),
            ),
          ],
        ),
        Text(
          'รายละเอียด',
          style: context.textTheme.titleSmall?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          product.description,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 13,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: context.themeColor.surface,
        border: Border.all(color: context.themeColor.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
