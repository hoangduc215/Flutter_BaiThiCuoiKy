import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/home/home_state.dart';
import 'package:flutter_baithicuoiky/models/product_model.dart';
import 'package:flutter_baithicuoiky/core/services/api_service.dart';

class HomeController extends ChangeNotifier {
  HomeState _state = HomeState.initial();
  HomeState get state => _state;

  Future<void> loadProducts() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      // GỌI API DỂ LẤY 100 SẢN PHẨM:
      final phones = await ApiService.fetchPhones(100);
      final accessories = await ApiService.fetchAccessories(100);

      // LƯU VÀO STATE:
      _state = _state.copyWith(
        isLoading: false,
        phones: _getTopRated(phones, top: 20),
        accessories: _getTopRated(accessories, top: 20),
      );
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }

  // LẤY 20 SẢN PHẨM CÓ ĐÁNH GIÁ CAO NHẤT:
  List<Product> _getTopRated(List<Product> products, {int top = 20}) {
    final sorted = products.toList()
      ..sort((a, b) => b.rating!.compareTo(a.rating ?? 0));
    return sorted.take(top).toList();
  }
}
