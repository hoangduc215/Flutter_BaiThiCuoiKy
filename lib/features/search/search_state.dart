import 'package:flutter_baithicuoiky/models/product_model.dart';

class SearchState {
  final bool isLoading;
  final String? error;
  final List<Product> results;

  const SearchState({
    required this.isLoading,
    required this.results,
    this.error,
  });

  factory SearchState.initial() {
    return const SearchState(isLoading: false, results: [], error: null);
  }

  SearchState copyWith({
    bool? isLoading,
    String? error,
    List<Product>? results,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      results: results ?? this.results,
    );
  }
}
