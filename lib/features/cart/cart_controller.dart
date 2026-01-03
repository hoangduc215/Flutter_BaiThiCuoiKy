import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/core/services/api_service.dart';
import 'package:flutter_baithicuoiky/features/cart/cart_state.dart';
import 'package:flutter_baithicuoiky/models/cart_model.dart';

class CartController extends ChangeNotifier {
  final ApiService api;

  CartController({required this.api});

  CartState _state = CartState.initial();
  CartState get state => _state;

  // LẤY GIỎ HÀNG DỰA TRÊN ID NGƯỜI DÙNG:
  Future<void> fetchCart(int userId) async {
    if (_state.cart != null) return;
    try {
      _state = _state.copyWith(isLoading: true, error: null);
      notifyListeners();

      final response = await api.getUserCart(userId);

      // TRƯỜNG HỢP NGƯỜI DÙNG KHÔNG CÓ GIỎ HÀNG NÀO THÌ TẠO 1 MỚI 1 CART RỖNG:
      final cart = response.carts.isNotEmpty
          ? response.carts.first
          : CartModel(
              id: 0,
              userId: userId,
              items: [],
              totalQuantity: 0,
              totalProducts: 0,
              total: 0,
              discountedTotal: 0,
            );

      _state = _state.copyWith(isLoading: false, cart: cart);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }

  //THÊM 1 SẢN PHẨM VÀO GIỎ:
  void addToCart(CartItem newItem, int userId) {
    final cart = _state.cart;

    // CHƯA CÓ CART:
    if (cart == null) {
      _state = _state.copyWith(
        cart: CartModel(
          id: 0,
          userId: userId,
          items: [newItem],
          totalQuantity: newItem.quantity,
          totalProducts: 1,
          total: newItem.total,
          discountedTotal: newItem.discountedTotal,
        ),
      );
      notifyListeners();
      return;
    }

    // ĐÃ CÓ CART:
    final index = cart.items.indexWhere(
      (e) => e.productId == newItem.productId,
    );

    List<CartItem> items;

    if (index >= 0) {
      final oldItem = cart.items[index];
      final newQty = oldItem.quantity + newItem.quantity;

      items = [...cart.items];
      items[index] = oldItem.copyWith(
        quantity: newQty,
        total: oldItem.price * newQty,
        discountedTotal: _calcDiscounted(
          oldItem.price,
          newQty,
          oldItem.discountPercentage,
        ),
      );
    } else {
      items = [...cart.items, newItem];
    }
    _rebuildCart(items);
  }

  // TĂNG SỐ LƯỢNG SẢN PHẨM:
  void increaseQuantity(int productId) {
    final items = _state.cart!.items.map((item) {
      if (item.productId == productId) {
        final newQty = item.quantity + 1;
        return item.copyWith(
          quantity: newQty,
          total: item.price * newQty,
          discountedTotal: _calcDiscounted(
            item.price,
            newQty,
            item.discountPercentage,
          ),
        );
      }
      return item;
    }).toList();

    _rebuildCart(items);
  }

  // GIẢM SỐ LƯỢNG SẢN PHẨM:
  void decreaseQuantity(int productId) {
    final items = _state.cart!.items.map((item) {
      if (item.productId == productId && item.quantity > 1) {
        final newQty = item.quantity - 1;
        return item.copyWith(
          quantity: newQty,
          total: item.price * newQty,
          discountedTotal: _calcDiscounted(
            item.price,
            newQty,
            item.discountPercentage,
          ),
        );
      }
      return item;
    }).toList();

    _rebuildCart(items);
  }

  // XÓA 1 SẢN PHẨM:
  void removeItem(int productId) {
    final items = _state.cart!.items
        .where((e) => e.productId != productId)
        .toList();

    _rebuildCart(items);
  }

  // XÓA HẾT GIỎ HÀNG, TRƯỜNG HỢP ĐĂNG HOẶC THANH TOÁN XONG:
  void clear() {
    _state = CartState.initial();
    notifyListeners();
  }

  // TÍNH LẠI TOÀN BỘ GIỎ HÀNG MỖI LẦN THÊM SỬA XÓA:
  void _rebuildCart(List<CartItem> items) {
    final totalQuantity = items.fold<int>(0, (sum, e) => sum + e.quantity);
    final totalProducts = items.length;
    final total = items.fold<double>(0, (sum, e) => sum + e.total);
    final discountedTotal = items.fold<double>(
      0,
      (sum, e) => sum + e.discountedTotal,
    );

    _state = _state.copyWith(
      cart: _state.cart!.copyWith(
        items: items,
        totalQuantity: totalQuantity,
        totalProducts: totalProducts,
        total: total,
        discountedTotal: discountedTotal,
      ),
    );

    notifyListeners();
  }

  // TÍNH TIỀN SAU KHI ÁP DỤNG GIẢM GIÁ:
  double _calcDiscounted(
    double price,
    int quantity,
    double discountPercentage,
  ) {
    final total = price * quantity;
    return total * (1 - discountPercentage / 100);
  }
}
