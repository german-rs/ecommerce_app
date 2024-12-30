import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product_model.dart';

class ProductViewModel with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  void setProducts(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(ProductModel updatedProduct) {
    final index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    _products.removeWhere((p) => p.id == productId);
    notifyListeners();
  }
}
