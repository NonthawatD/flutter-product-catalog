import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_catalog_application/features/product/controller/product_detail_controller.dart';
import 'package:product_catalog_application/features/product/controller/product_list_controller.dart';

final productListProvider =
    ChangeNotifierProvider.autoDispose<ProductListController>((ref) {
      return ProductListController(ref: ref);
    });

final productDetailProvider =
    ChangeNotifierProvider.autoDispose<ProductDetailController>((ref) {
      return ProductDetailController(ref: ref);
    });
