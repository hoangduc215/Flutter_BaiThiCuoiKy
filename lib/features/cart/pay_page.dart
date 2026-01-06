import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/models/cart_model.dart';
import 'package:flutter_baithicuoiky/features/product/product_detail_page.dart';
import 'package:iconsax/iconsax.dart';

class PayPage extends StatelessWidget {
  final List<CartItem> items;

  const PayPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // TỔNG GIÁ CHƯA TÍNH:
    final totalProductPrice = items.fold<double>(
      0,
      (sum, item) => sum + item.discountedTotal,
    );

    // PHÍ SHIP TIỀN ĐÔ:
    const shippingFee = 1.2;

    // GIẢM GIÁ TIỀN ĐÔ:
    const discount = 1.90;

    // TỔNG GIÁ CẢ SHIP VÀ GIẢM GIÁ:
    final totalPayment = totalProductPrice + shippingFee - discount;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // APP BAR Ở ĐÂY:
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                // ================= NGƯỜI NHẬN =================
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.person, color: Colors.blue),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Người nhận: Hoàng Minh Đức | 0909xxxxxx',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ================= ĐỊA CHỈ =================
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.location_on, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Địa chỉ giao hàng',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Số 123, Đường ABC, Quận XYZ, Hà Nội',
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Ghi chú cho người bán',
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ================= SẢN PHẨM =================
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sản phẩm',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      ...items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  item.thumbnail,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'x${item.quantity}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                formatPrice(item.discountedTotal),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ================= VẬN CHUYỂN =================
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.local_shipping, color: Colors.green),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Giao hàng nhanh (1–2 ngày)',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text('25.000đ', style: TextStyle(color: Colors.red)),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ================= VOUCHER SHOP =================
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.store, color: Colors.orange),
                      SizedBox(width: 8),
                      Expanded(child: Text('Voucher của Shop')),
                      Text('Chọn', style: TextStyle(color: Colors.red)),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ================= VOUCHER NỀN TẢNG =================
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.confirmation_number, color: Colors.purple),
                      SizedBox(width: 8),
                      Expanded(child: Text('Voucher nền tảng')),
                      Text('Chọn', style: TextStyle(color: Colors.red)),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ================= THANH TOÁN =================
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Phương thức thanh toán',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.money, color: Colors.green),
                        title: Text('Thanh toán khi nhận hàng (COD)'),
                        trailing: Icon(Icons.check_circle, color: Colors.green),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.credit_card),
                        title: Text('Thẻ ngân hàng / Ví điện tử'),
                        trailing: Icon(Icons.radio_button_unchecked),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ================= CHI TIẾT GIÁ =================
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(child: Text('Tổng tiền hàng')),
                          Text(formatPrice(totalProductPrice)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Expanded(child: Text('Phí vận chuyển')),
                          Text(formatPrice(shippingFee)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Expanded(child: Text('Giảm giá')),
                          Text(
                            '-${formatPrice(discount)}',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Tổng thanh toán',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            formatPrice(totalPayment),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
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

          // ================= THANH DƯỚI =================
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Tổng thanh toán'),
                      Text(
                        formatPrice(totalPayment),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đặt hàng thành công!')),
                    );
                  },
                  child: const Text(
                    'Đặt hàng',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
  PreferredSizeWidget buildAppBar(context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        title: const Text(
          "THANH TOÁN",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
        // ICON BACK:
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
    );
  }
}
