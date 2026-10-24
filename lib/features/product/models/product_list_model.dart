import 'package:product_catalog_application/features/product/models/product_model.dart';

class ProductListModel {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  const ProductListModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      products: (json['products'] as List? ?? [])
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}