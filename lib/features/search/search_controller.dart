import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/core/services/api_service.dart';
import 'package:flutter_baithicuoiky/features/search/search_state.dart';
import 'package:flutter_baithicuoiky/models/product_model.dart';

class SearchController extends ChangeNotifier {
  SearchState _state = SearchState.initial();
  SearchState get state => _state;

  // CACHE tất cả sản phẩm
  List<Product> _allProducts = [];

  /// SEARCH ENTRY POINT
  Future<void> loadAllProducts() async {
    if (_allProducts.isNotEmpty) return; // đã load rồi, không gọi lại API

    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final phones = await ApiService.fetchPhones(100);
      final accessories = await ApiService.fetchAccessories(100);
      _allProducts = [...phones, ...accessories];

      _state = _state.copyWith(isLoading: false, results: _allProducts);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }

  /// Lọc/search từ cache
  void search({String? keyword, String? brand, String? loai}) {
    List<Product> filtered = _allProducts;

    // Lọc theo loại
    if (loai == 'DienThoai') {
      filtered = filtered.where((p) => p.category == 'smartphones').toList();
    } else if (loai == 'PhuKien') {
      filtered = filtered
          .where((p) => p.category == 'mobile-accessories')
          .toList();
    }

    // Lọc theo hãng
    if (brand != null && brand.isNotEmpty) {
      filtered = filtered
          .where((p) => p.brand?.toLowerCase() == brand.toLowerCase())
          .toList();
    }

    // Lọc theo từ khóa
    if (keyword != null && keyword.trim().isNotEmpty) {
      final kw = keyword.toLowerCase().trim();
      filtered = filtered.where((p) {
        final name = p.title?.toLowerCase() ?? '';
        final productBrand = p.brand?.toLowerCase() ?? '';
        return name.contains(kw) || productBrand.contains(kw);
      }).toList();
    }

    _state = _state.copyWith(results: filtered);
    notifyListeners();
  }
}
