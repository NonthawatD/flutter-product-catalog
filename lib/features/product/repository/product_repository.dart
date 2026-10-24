import 'package:product_catalog_application/configs/app_config.dart';
import 'package:product_catalog_application/configs/network/api_calling.dart';
import 'package:product_catalog_application/features/product/models/product_list_model.dart';
import 'package:product_catalog_application/features/product/models/product_model.dart';

class ProductRepository {
  Future<ProductListModel> fetchProductsGetAll({required int limit, required int skip}) async {
    final data = await locator<ApiCalling>().get(
      path: Endpoint.products,
      queryParameters: {'limit': limit, 'skip': skip},
    );
    return ProductListModel.fromJson(data);
  }

  Future<ProductModel> fetchProductGetOne({required int productId}) async {
    final data = await locator<ApiCalling>().get(path: '${Endpoint.products}/$productId');
    return ProductModel.fromJson(data);
  }
}