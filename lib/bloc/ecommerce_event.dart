part of 'ecommerce_bloc.dart';

sealed class EcommerceEvent extends Equatable {
  const EcommerceEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends EcommerceEvent {}

class LoadCartItemsEvent extends EcommerceEvent {}

class LoadCatalogProductsEvent extends EcommerceEvent {}

class AddToCartEvent extends EcommerceEvent {
  final ProductModel product;

  const AddToCartEvent({required this.product});
}

class UpdateCartQuantityEvent extends EcommerceEvent {
  final ProductModel product;
  final int newQty;
  const UpdateCartQuantityEvent({
    required this.product,
    required this.newQty,
  });
}

class RemoveCartItemEvent extends EcommerceEvent {
  final ProductModel product;
  const RemoveCartItemEvent({required this.product});
}

class UpdateCatalogProductEvent extends EcommerceEvent {
  final ProductModel product;

  const UpdateCatalogProductEvent({required this.product});
}

class DeleteCatalogProductEvent extends EcommerceEvent {
  final ProductModel product;

  const DeleteCatalogProductEvent({required this.product});
}

class CreateNewProductEvent extends EcommerceEvent {
  final String description;
  final String imageUrl;
  final double price;

  const CreateNewProductEvent({
    required this.description,
    required this.imageUrl,
    required this.price,
  });
}
