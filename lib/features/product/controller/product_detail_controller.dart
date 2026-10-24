import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_catalog_application/configs/network/network_exception.dart';
import 'package:product_catalog_application/controllers/safe_change_notifier.dart';
import 'package:product_catalog_application/features/product/models/product_model.dart';
import 'package:product_catalog_application/features/product/repository/product_repository.dart';

class ProductDetailController extends SafeChangeNotifier {
  final Ref ref;
  final productRepository = ProductRepository();

  ProductDetailController({required this.ref});

  ProductModel? productData;
  bool isLoadProductGetOne = true;
  String? errorMessage;

  Future<void> fetchProductGetOne({required int productId}) async {
    isLoadProductGetOne = true;
    errorMessage = null;
    notifyListeners();
    try {
      productData = await productRepository.fetchProductGetOne(productId: productId);
    } on NetworkException catch (e) {
      errorMessage = e.message;
    } finally {
      isLoadProductGetOne = false;
      notifyListeners();
    }
  }
}