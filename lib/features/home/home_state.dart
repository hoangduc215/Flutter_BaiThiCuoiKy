import 'package:flutter_baithicuoiky/models/product_model.dart';

class HomeState {
  final bool isLoading;
  final String? error;

  final List<Product> phones;
  final List<Product> accessories;

  HomeState({
    required this.isLoading,
    required this.phones,
    required this.accessories,
    this.error,
  });

  factory HomeState.initial() {
    return HomeState(isLoading: false, phones: [], accessories: []);
  }

  HomeState copyWith({
    bool? isLoading,
    List<Product>? phones,
    List<Product>? accessories,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      phones: phones ?? this.phones,
      accessories: accessories ?? this.accessories,
      error: error,
    );
  }
}
