import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_catalog_application/features/product/providers/product_provider.dart';
import 'package:product_catalog_application/features/product/screen/product_detail_screen.dart';
import 'package:product_catalog_application/features/product/widget/catalog_app_bar.dart';
import 'package:product_catalog_application/features/product/widget/empty_state_view.dart';
import 'package:product_catalog_application/features/product/widget/error_state_view.dart';
import 'package:product_catalog_application/features/product/widget/product_grid.dart';
import 'package:product_catalog_application/features/product/widget/product_grid_skeleton.dart';

class ProductListScreen extends HookConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(productListProvider);

    final hasProducts = controller.products.isNotEmpty;
    final showLoading = controller.isLoadProductGetAll && !hasProducts;
    final showError =
        !controller.isLoadProductGetAll &&
        controller.errorMessage != null &&
        !hasProducts;
    final showEmptyState =
        !controller.isLoadProductGetAll &&
        controller.errorMessage == null &&
        !hasProducts;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchProductGetAll();
      });
      return null;
    }, []);

    return Scaffold(
      appBar: const CatalogAppBar(),
      body: showLoading
          ? ProductGridSkeleton()
          : showError
          ? ErrorStateView(
              message: controller.errorMessage!,
              onRetry: controller.fetchProductGetAll,
            )
          : showEmptyState
          ? EmptyStateView(onRefresh: controller.refreshProduct)
          : ProductGrid(
              controller: controller,
              onProductTap: (product) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(productId: product.id),
                ),
              ),
            ),
    );
  }
}
