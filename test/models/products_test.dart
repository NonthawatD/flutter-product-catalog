import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog_application/features/product/models/product_model.dart';

void main() {
  test('parses meta as a single object', () {
    final product = ProductModel.fromJson({
      'id': 1,
      'dimensions': {'width': 10, 'height': 20, 'depth': 5},
      'meta': {
        'createdAt': '2025-10-09T14:47:01.588Z',
        'updatedAt': '2026-05-23T11:27:41.868Z',
        'barcode': '5784719087687',
        'qrCode': 'https://cdn.dummyjson.com/public/qr-code.png',
      },
    });

    expect(product.meta, isA<Meta>());
    expect(product.meta.barcode, '5784719087687');
    expect(product.meta.createdAt, DateTime.parse('2025-10-09T14:47:01.588Z'));
    expect(product.meta.updatedAt, DateTime.parse('2026-05-23T11:27:41.868Z'));
  });
}
