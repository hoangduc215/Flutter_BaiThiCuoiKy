import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/core/services/api_service.dart';
import 'package:flutter_baithicuoiky/features/home/home_state.dart';
import 'package:flutter_baithicuoiky/models/product_model.dart';

class HomeController extends ChangeNotifier {
  HomeState _state = HomeState.initial();
  HomeState get state => _state;

  Future<void> loadProducts() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      //LẤY ĐIỆN THOẠI:
      final phones = await ApiService.fetchPhones(100);
      final topRatedPhones = getTopRatedPhones(phones, top: 20);

      //LẤY PHỤ KIỆN:
      final accessories = await ApiService.fetchAccessories(100);
      final topRatedAccessories = getTopRatedPhones(accessories, top: 20);

      //TRẢ VỀ BÊN
      _state = _state.copyWith(
        isLoading: false,
        phones: topRatedPhones,
        accessories: topRatedAccessories,
      );
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }
    notifyListeners();
  }
}

List<Product> getTopRatedPhones(List<Product> phones, {int top = 20}) {
  final sorted = phones.toList()..sort((a, b) => b.rating.compareTo(a.rating));
  return sorted.take(top).toList();
}

List<Product> getRatedAccessories(List<Product> accessories, {int top = 20}) {
  final sorted = accessories.toList()
    ..sort((a, b) => b.rating.compareTo(a.rating));
  return sorted.take(top).toList();
}
