import 'dart:async';
import '../models/product.dart';

class ProductRepository {
  final List<Product> _products = [
    Product(id: 1, name: 'MacBook Pro M3', price: 1999.99),
    Product(id: 2, name: 'iPhone 15 Pro', price: 999.99),
  ];

  final StreamController<Product> _liveAddedController =
      StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_products);
  }

  Stream<Product> liveAdded() => _liveAddedController.stream;

  void addProduct(Product product) {
    _products.add(product);
    _liveAddedController.add(product);
  }

  void dispose() {
    _liveAddedController.close();
  }
}
