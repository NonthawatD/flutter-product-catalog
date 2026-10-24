import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_catalog_application/features/product/providers/product_provider.dart';
import 'package:product_catalog_application/features/product/widget/detail_app_bar.dart';
import 'package:product_catalog_application/features/product/widget/error_state_view.dart';
import 'package:product_catalog_application/features/product/widget/product_detail_body.dart';

class ProductDetailScreen extends HookConsumerWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(productDetailProvider);
    final product = controller.productData;

    final showLoading = controller.isLoadProductGetOne;
    final showError =
        !controller.isLoadProductGetOne && controller.errorMessage != null;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchProductGetOne(productId: productId);
      });
      return null;
    }, []);

    return Scaffold(
      appBar: const DetailAppBar(),
      body: showLoading
          ? const Center(child: CircularProgressIndicator())
          : showError
          ? ErrorStateView(
              message: controller.errorMessage!,
              onRetry: () =>
                  controller.fetchProductGetOne(productId: productId),
            )
          : product == null
          ? const SizedBox.shrink()
          : ProductDetailBody(product: product),
    );
  }
}
