import 'package:flutter_baithicuoiky/models/cart_model.dart';

class CartState {
  final bool isLoading;
  final CartModel? cart;
  final String? error;

  CartState({required this.isLoading, required this.cart, this.error});

  factory CartState.initial() {
    return CartState(isLoading: false, cart: null, error: null);
  }

  CartState copyWith({bool? isLoading, CartModel? cart, String? error}) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cart: cart ?? this.cart,
      error: error,
    );
  }
}
