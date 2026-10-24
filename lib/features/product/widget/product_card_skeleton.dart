import 'package:flutter/material.dart';
import 'package:product_catalog_application/utils/context_extension.dart';
import 'package:product_catalog_application/widgets/skeleton_box.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.themeColor.surface,
        border: Border.all(color: context.themeColor.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Expanded(
            child: SkeletonBox(
              width: double.infinity,
              radius: 12,
              height: null,
            ),
          ), // รูป
          SkeletonBox(width: double.infinity, height: 14),
          SkeletonBox(width: 90, height: 14),
          SkeletonBox(width: 60, height: 16),
        ],
      ),
    );
  }
}
