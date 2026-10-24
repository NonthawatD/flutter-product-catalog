import 'package:flutter/material.dart';
import 'package:product_catalog_application/features/product/controller/product_list_controller.dart';
import 'package:product_catalog_application/features/product/models/product_model.dart';
import 'package:product_catalog_application/features/product/widget/product_card.dart';
import 'package:product_catalog_application/features/product/widget/product_grid_delegate.dart';
import 'package:product_catalog_application/features/product/widget/product_list_footer.dart';
import 'package:product_catalog_application/utils/context_extension.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.controller, this.onProductTap});

  final ProductListController controller;
  final ValueChanged<ProductModel>? onProductTap;

  @override
  Widget build(BuildContext context) {
    final products = controller.products;
    final padding = MediaQuery.sizeOf(context).width < 600 ? 16.0 : 24.0;

    return RefreshIndicator(
      onRefresh: controller.refreshProduct,
      color: context.themeColor.primary,
      backgroundColor: context.themeColor.surface,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // 1) ข้อความจำนวนรายการ
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(padding, padding, padding, 0),
              child: Text(
                'แสดง ${products.length} จาก ${controller.total} รายการ',
                style: context.textTheme.bodySmall,
              ),
            ),
          ),
          // 2) Grid สินค้า
          SliverPadding(
            padding: EdgeInsets.fromLTRB(padding, 12, padding, padding),
            sliver: SliverGrid.builder(
              gridDelegate: productGridDelegate(context),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onTap: onProductTap == null
                      ? null
                      : () => onProductTap!(product),
                );
              },
            ),
          ),
          // 3) ส่วนท้ายลิสต์
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(padding, 0, padding, 24),
              child: ProductListFooter(controller: controller),
            ),
          ),
        ],
      ),
    );
  }
}
