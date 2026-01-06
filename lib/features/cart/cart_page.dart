import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/auth/login_controller.dart';
import 'package:flutter_baithicuoiky/features/cart/cart_controller.dart';
import 'package:flutter_baithicuoiky/features/cart/pay_page.dart';
import 'package:flutter_baithicuoiky/features/product/product_detail_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // TRÁNH CHO LẶP ĐI LẶP LẠI API fetch CART:
  int? _lastUserId;

  // DANH SÁCH SẢN PHẨM CHỌN TẤT CẢ LƯU ID SẢN PHẨM:
  final Set<int> _selectedProductIds = {};
  bool _selectAll = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // LẤY USER TỪ LOGIN CONTROLLER:
    final loginState = context.read<LoginController>().state;
    final user = loginState.user;

    // NẾU NGƯỜI DÙNG CÓ TỒN TẠI THÌ ;ẤY ID NGƯỜI DÙNG:
    if (user != null && user.id != _lastUserId) {
      _lastUserId = user.id;
      context.read<CartController>().fetchCart(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    // LẤY STATE TỪ CART CONTROLLER:
    final cartState = context.watch<CartController>().state;

    // ĐANG LOAD:
    if (cartState.isLoading) {
      return Scaffold(
        // APP BAR Ở ĐÂY:
        appBar: buildAppBar(),

        // BODY Ở ĐÂY:
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // GIỎ TRỐNG:
    if (cartState.cart == null || cartState.cart!.items.isEmpty) {
      return Scaffold(
        // APP BAR Ở ĐÂY:
        appBar: buildAppBar(),

        // BODY Ở ĐÂY:
        body: Center(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 90,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Giỏ hàng của bạn đang trống',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Hãy thêm sản phẩm để bắt đầu mua sắm nhé!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // LẤY GIỎ HÀNG TỪ STATE:
    final cart = cartState.cart!;
    final controller = context.read<CartController>();

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      // APP BAR Ở ĐÂY:
      appBar: buildAppBar(),
      // BODY Ở ĐÂY:
      body: Column(
        children: [
          // NÚT CHECK BOX VÀ SỐ LƯỢNG:
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  /// CHECKBOX CHỌN TẤT CẢ
                  Checkbox(
                    value: _selectAll,
                    onChanged: (value) {
                      setState(() {
                        _selectAll = value ?? false;
                        _selectedProductIds.clear();
                        if (_selectAll) {
                          for (final item in cart.items) {
                            _selectedProductIds.add(item.productId);
                          }
                        }
                      });
                    },
                  ),

                  const Text('Sản phẩm', style: TextStyle(fontSize: 13)),

                  const Spacer(),
                  const Text('Số lượng', style: TextStyle(fontSize: 13)),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),

          // DANH SÁCH SẢN PHẨM:
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: cart.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = cart.items[index];

                return Dismissible(
                  key: ValueKey(item.productId),
                  direction: DismissDirection.endToStart,

                  /// NỀN KHI TRƯỢT:
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  /// KHI THẢ TAY → XOÁ
                  onDismissed: (_) {
                    controller.removeItem(item.productId);
                    _selectedProductIds.remove(item.productId);
                  },

                  // DANH SÁCH SẢN PHẨM:
                  child: Container(
                    height: 130,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// CHECKBOX ITEM
                        SizedBox(
                          width: 28,
                          child: Checkbox(
                            visualDensity: VisualDensity.compact,
                            value: _selectedProductIds.contains(item.productId),
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  _selectedProductIds.add(item.productId);
                                } else {
                                  _selectedProductIds.remove(item.productId);
                                }

                                /// CẬP NHẬT CHỌN TẤT CẢ
                                _selectAll =
                                    _selectedProductIds.length ==
                                    cart.items.length;
                              });
                            },
                          ),
                        ),

                        /// ẢNH
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            item.thumbnail,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 10),

                        /// THÔNG TIN
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// TÊN
                              Text(
                                item.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),

                              const SizedBox(height: 4),

                              /// GIÁ GỐC + % GIẢM
                              Row(
                                children: [
                                  Text(
                                    formatPrice(item.price),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '-${item.discountPercentage.toStringAsFixed(0)}%',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const Spacer(),

                              /// GIÁ SAU GIẢM + SỐ LƯỢNG
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /// GIÁ 1 SẢN PHẨM:
                                  Text(
                                    formatPrice(
                                      item.price *
                                          (1 - item.discountPercentage / 100),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),

                                  /// + - SỐ LƯỢNG
                                  Container(
                                    height: 28,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // TRỪ SỐ LƯỢNG:
                                        _qtyButton(
                                          icon: Icons.remove,
                                          onTap: () => controller
                                              .decreaseQuantity(item.productId),
                                        ),
                                        Container(
                                          width: 32,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${item.quantity}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        // CỘNG SỐ LƯỢNG:
                                        _qtyButton(
                                          icon: Icons.add,
                                          onTap: () => controller
                                              .increaseQuantity(item.productId),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // TỔNG TIỀN + THANH TOÁN
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: const Offset(0, -3),
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// THÔNG TIN TỔNG
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// SỐ SẢN PHẨM + SỐ LƯỢNG
                      Text(
                        '${_selectedProductIds.length} sản phẩm · '
                        '${soLuongSanPhamDuocTick(cart.items)} món',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// TỔNG TIỀN
                      Text(
                        formatPrice(tongSoTienSanPhamDuocTick(cart.items)),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),

                /// NÚT THANH TOÁN
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _selectedProductIds.isEmpty
                        ? null
                        : () {
                            final selectedItems = cart.items
                                .where(
                                  (item) => _selectedProductIds.contains(
                                    item.productId,
                                  ),
                                )
                                .toList();
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                builder: (_) => PayPage(items: selectedItems),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    child: const Text(
                      'Thanh toán',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //  ----------------------------------- HÀM APP BAR Ở ĐÂY:  -------------------------------
  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        title: const Text(
          "GIỎ HÀNG CỦA BẠN",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
        centerTitle: true,
      ),
    );
  }

  //  ----------------------------------- HÀM APP BAR Ở ĐÂY:  -------------------------------
  // HÀM CỘNG TRỪ SỐ LƯỢNG:
  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: Icon(icon, size: 16),
      ),
    );
  }

  // TỔNG SỐ LƯỢNG SẢN PHẨM ĐƯỢC TICK:
  int soLuongSanPhamDuocTick(List items) {
    int total = 0;

    for (final item in items) {
      if (_selectedProductIds.contains(item.productId)) {
        total += item.quantity as int;
      }
    }

    return total;
  }

  // TỔNG TIỀN SẢN PHẨM ĐƯỢC TICK:
  double tongSoTienSanPhamDuocTick(List items) {
    double total = 0;

    for (final item in items) {
      if (_selectedProductIds.contains(item.productId)) {
        final priceAfterDiscount =
            item.price * (1 - item.discountPercentage / 100);

        total += priceAfterDiscount * item.quantity;
      }
    }

    return total;
  }
}
