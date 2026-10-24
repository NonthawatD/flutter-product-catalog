import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_catalog_application/configs/network/network_exception.dart';
import 'package:product_catalog_application/controllers/safe_change_notifier.dart';
import 'package:product_catalog_application/features/product/models/product_model.dart';
import 'package:product_catalog_application/features/product/repository/product_repository.dart';

class ProductListController extends SafeChangeNotifier {
  final Ref ref;
  final productRepository = ProductRepository();

  ProductListController({required this.ref});

  static const int pageSize = 20;

  List<ProductModel> products = [];
  int total = 0;

  bool isLoadProductGetAll = true;
  String? errorMessage;
  String? loadMoreErrorMessage;
  bool isRefreshing = false;
  bool isLoadingMore = false;
  bool get hasMore => products.length < total;

  Future<void> fetchProductGetAll() async {
    isLoadProductGetAll = true;
    errorMessage = null;
    notifyListeners();
    try {
      await Future.delayed(const Duration(seconds: 3));
      final res = await productRepository.fetchProductsGetAll(
        limit: pageSize,
        skip: 0,
      );
      products = res.products;

      total = res.total;
    } on NetworkException catch (e) {
      errorMessage = e.message;
    } finally {
      isLoadProductGetAll = false;
      notifyListeners();
    }
  }

  Future<void> fetchMore() async {
    if (isLoadingMore || isLoadProductGetAll || isRefreshing || !hasMore) return;

    isLoadingMore = true;
    loadMoreErrorMessage = null;
    notifyListeners();
    try {
      final res = await productRepository.fetchProductsGetAll(
        limit: pageSize,
        skip: products.length,
      );
      products = [...products, ...res.products]; // สร้าง list ใหม่ ไม่ mutate
      total = res.total;
    } on NetworkException catch (e) {
      loadMoreErrorMessage = e.message;
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> refreshProduct() async {
    if (isRefreshing || isLoadingMore) return;

    isRefreshing = true;
    try {
      final res = await productRepository.fetchProductsGetAll(
        limit: pageSize,
        skip: 0,
      );
      products = res.products;
      total = res.total;
      errorMessage = null;
      loadMoreErrorMessage = null;
    } on NetworkException catch (e) {
      if (products.isEmpty) errorMessage = e.message;
    } finally {
      isRefreshing = false;
      notifyListeners();
    }
  }
}
