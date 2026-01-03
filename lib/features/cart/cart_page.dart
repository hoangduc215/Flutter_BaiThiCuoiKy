import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/auth/login_controller.dart';
import 'package:flutter_baithicuoiky/features/cart/cart_controller.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // TRÁNH CHO LẶP ĐI LẶP LẠI API fetch CART:
  int? _lastUserId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // LẤY USER TỪ LOGIN CONTROLLER:
    final loginState = context.read<LoginController>().state;
    final user = loginState.user;

    // NẾU NGƯỜI DÙNG CÓ TỒN TẠI THÌ ẤY ID NGƯỜI DÙNG:
    if (user != null && user.id != _lastUserId) {
      _lastUserId = user.id;
      context.read<CartController>().fetchCart(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartController>().state;

    // ĐANG LOAD:
    if (cartState.isLoading) {
      return Scaffold(
        // APP BAR Ở ĐÂY:
        appBar: AppBar(title: const Text('Giỏ hàng')),

        // BODY Ở ĐÂY:
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // GIỎ TRỐNG:
    if (cartState.cart == null || cartState.cart!.items.isEmpty) {
      return Scaffold(
        // APP BAR Ở ĐÂY:
        appBar: AppBar(title: const Text('Giỏ hàng')),

        // BODY Ở ĐÂY:
        body: Center(
          child: Text('Giỏ hàng trống', style: TextStyle(fontSize: 18)),
        ),
      );
    }

    final cart = cartState.cart!;
    final controller = context.read<CartController>();

    return Scaffold(
      // APP BAR Ở ĐÂY:
      appBar: AppBar(title: const Text('Giỏ hàng')),

      // BODY Ở ĐÂY:
      body: Column(
        children: [
          // DANH SÁCH SẢN PHẨM:
          Expanded(
            child: ListView.separated(
              itemCount: cart.items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = cart.items[index];

                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('Giá: ${item.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () =>
                            controller.decreaseQuantity(item.productId),
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () =>
                            controller.increaseQuantity(item.productId),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // TỔNG TIỀN:
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.1)),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _row('Số sản phẩm', cart.totalProducts.toString()),
                _row('Số lượng', cart.totalQuantity.toString()),
                const Divider(),
                _row(
                  'Tổng tiền',
                  '${cart.discountedTotal.toStringAsFixed(0)} ₫',
                  isBold: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
