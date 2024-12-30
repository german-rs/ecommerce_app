import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product_model.dart';

class CartViewModel with ChangeNotifier {
  final List<ProductModel> _cart = [];

  List<ProductModel> get cart => _cart;

  void addToCart(ProductModel product) {
    final index = _cart.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      final updatedProduct = product.copyWith(
        quantity: _cart[index].quantity + 1,
      );
      _cart[index] = updatedProduct;
    } else {
      _cart.add(product.copyWith(quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cart.removeWhere((p) => p.id == productId);
    notifyListeners();
  }

  void updateCartQuantity(String productId, int quantity) {
    final index = _cart.indexWhere((p) => p.id == productId);
    if (index != -1) {
      final updatedProduct = _cart[index].copyWith(quantity: quantity);
      _cart[index] = updatedProduct;
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
