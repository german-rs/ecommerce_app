import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product_model.dart';

class CatalogViewModel with ChangeNotifier {
  List<ProductModel> _catalogProducts = [];

  List<ProductModel> get catalogProducts => _catalogProducts;

  void setCatalogProducts(List<ProductModel> products) {
    _catalogProducts = products;
    notifyListeners();
  }

  void addProductToCatalog(ProductModel product) {
    _catalogProducts.add(product);
    notifyListeners();
  }

  void updateCatalogProduct(ProductModel updatedProduct) {
    final index = _catalogProducts.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _catalogProducts[index] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteCatalogProduct(String productId) {
    _catalogProducts.removeWhere((p) => p.id == productId);
    notifyListeners();
  }
}
