import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';

part 'ecommerce_event.dart';
part 'ecommerce_state.dart';

var homeUrl = dotenv.env['FIREBASE_HOME_URL'] ?? '';
var cartUrl = dotenv.env['FIREBASE_CART_URL'] ?? '';

class EcommerceBloc extends Bloc<EcommerceEvent, EcommerceState> {
  var uuid = const Uuid();
  var dio = Dio();

  EcommerceBloc() : super(EcommerceState.initial()) {
    on<LoadProductsEvent>(_onLoadProductsEvent);
    on<LoadCartItemsEvent>(_onLoadCartItemsEvent);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<UpdateCartQuantityEvent>(_onUpdateCartQuantityEvent);
    on<RemoveCartItemEvent>(_onRemoveCartItemEvent);
    on<LoadCatalogProductsEvent>(_onLoadCatalogProductsEvent);
    on<CreateNewProductEvent>(_onCreateNewProductEvent);
    on<UpdateCatalogProductEvent>(_onUpdateCatalogProductEvent);
    on<DeleteCatalogProductEvent>(_onDeleteCatalogProductEvent);
  }

  void _onLoadProductsEvent(
      LoadProductsEvent event, Emitter<EcommerceState> emit) async {
    emit(state.copyWith(homeScreenState: HomeScreenState.loading));

    final response = await dio.get('$homeUrl.json');
    final data = response.data as Map<String, dynamic>?;
    final responseCart = await dio.get('$cartUrl.json');
    final dataCart = responseCart.data as Map<String, dynamic>?;

    if (data == null) {
      emit(
        state.copyWith(
          homeScreenState: HomeScreenState.success,
          products: [],
        ),
      );
      return;
    }

    final products = data.entries.map((prod) {
      return ProductModel(
        id: prod.key,
        name: prod.value["description"],
        price: double.parse(prod.value["price"].toString()),
        imageUrl: prod.value["image_url"],
      );
    }).toList();

    List<ProductModel> cartListItems = [];
    if (dataCart != null) {
      cartListItems = dataCart.entries.map((prod) {
        return ProductModel(
          id: prod.key,
          name: prod.value["description"],
          price: double.parse(prod.value["price"].toString()),
          imageUrl: prod.value["image_url"],
          quantity: prod.value["quantity"] ?? 1,
        );
      }).toList();
    }

    emit(state.copyWith(
      homeScreenState: HomeScreenState.success,
      products: products,
      cart: cartListItems,
    ));
  }

  void _onLoadCartItemsEvent(
      LoadCartItemsEvent event, Emitter<EcommerceState> emit) async {
    final response = await dio.get('$cartUrl.json');
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state.copyWith(cart: []));
      return;
    }

    final cartItems = data.entries.map((prod) {
      final product = prod.value;
      return ProductModel(
        id: product["id"],
        name: product["description"],
        price: double.parse(product["price"].toString()),
        imageUrl: product["image_url"],
        quantity: product["quantity"] ?? 1,
      );
    }).toList();

    emit(state.copyWith(
      cart: cartItems,
    ));
  }

  void _onAddToCartEvent(
      AddToCartEvent event, Emitter<EcommerceState> emit) async {
    final ProductModel product = event.product;

    final existItemIndex = state.cart.indexWhere((p) => p.id == product.id);

    if (existItemIndex >= 0) {
      final productItem = state.cart[existItemIndex];
      final newQuantity = productItem.quantity + 1;

      await dio.patch(
        "$cartUrl/${product.id}.json",
        data: {
          "quantity": newQuantity,
        },
      );

      final updateCart = [...state.cart];
      updateCart[existItemIndex] = productItem.copyWith(quantity: newQuantity);

      emit(state.copyWith(cart: updateCart));
    } else {
      await dio.put(
        "$cartUrl/${product.id}.json",
        data: {
          "id": product.id,
          "description": product.name,
          "product": "",
          "image_url": product.imageUrl,
          "price": product.price,
          "quantity": 1,
        },
      );

      final updateCart = [...state.cart, product];
      emit(state.copyWith(cart: updateCart));
    }
  }

  void _onUpdateCartQuantityEvent(
      UpdateCartQuantityEvent event, Emitter<EcommerceState> emit) async {
    final product = event.product;
    final newQuantity = product.quantity + event.newQty;

    if (newQuantity <= 0) {
      await dio.delete("$cartUrl/${product.id}.json");
      final updatedCart = state.cart.where((p) => p.id != product.id).toList();
      emit(state.copyWith(cart: updatedCart));
    } else {
      await dio.patch("$cartUrl/${product.id}.json", data: {
        "quantity": newQuantity,
      });
      final updatedCart = [
        for (var p in state.cart)
          if (p.id == product.id) p.copyWith(quantity: newQuantity) else p
      ];

      emit(state.copyWith(cart: updatedCart));
    }
  }

  void _onRemoveCartItemEvent(
      RemoveCartItemEvent event, Emitter<EcommerceState> emit) async {
    final ProductModel product = event.product;

    await dio.delete("$cartUrl/${product.id}.json");

    final updatedCart =
        state.cart.where((p) => p.id != event.product.id).toList();

    emit(state.copyWith(cart: updatedCart));
  }

  void _onLoadCatalogProductsEvent(
      LoadCatalogProductsEvent event, Emitter<EcommerceState> emit) async {
    final response = await dio.get('$homeUrl.json');
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(
        state.copyWith(
          catalogScreenState: CatalogScreenState.success,
          catalogProducts: [],
        ),
      );
      return;
    }

    final catalogProducts = data.entries.map((prod) {
      return ProductModel(
        id: prod.key,
        name: prod.value["description"],
        price: double.parse(prod.value["price"].toString()),
        imageUrl: prod.value["image_url"],
      );
    }).toList();

    emit(state.copyWith(
      catalogScreenState: CatalogScreenState.success,
      catalogProducts: catalogProducts,
    ));
  }

  void _onCreateNewProductEvent(
      CreateNewProductEvent event, Emitter<EcommerceState> emit) async {
    final String prodUID = uuid.v1();
    final data = {
      "id": prodUID,
      "description": event.description,
      "product": "",
      "image_url": event.imageUrl,
      "price": event.price,
    };

    await dio.put("$homeUrl/$prodUID.json", data: data);

    final newProduct = ProductModel(
      id: prodUID,
      name: event.description,
      imageUrl: event.imageUrl,
      price: event.price,
    );

    final updatedProducts = [...state.catalogProducts, newProduct];

    emit(state.copyWith(catalogProducts: updatedProducts));
  }

  void _onUpdateCatalogProductEvent(
      UpdateCatalogProductEvent event, Emitter<EcommerceState> emit) async {
    final product = event.product;

    await dio.put("$homeUrl/${product.id}.json", data: {
      "description": product.name,
      "image_url": product.imageUrl,
      "price": product.price,
    });

    final updatedProducts = [
      for (var p in state.catalogProducts)
        if (p.id == product.id) product else p
    ];

    emit(state.copyWith(catalogProducts: updatedProducts));
  }

  void _onDeleteCatalogProductEvent(
      DeleteCatalogProductEvent event, Emitter<EcommerceState> emit) async {
    final product = event.product;

    await dio.delete("$homeUrl/${product.id}.json");

    final updatedProducts =
        state.catalogProducts.where((p) => p.id != product.id).toList();

    emit(state.copyWith(catalogProducts: updatedProducts));
  }
}
