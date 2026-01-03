import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/auth/login_controller.dart';
import 'package:flutter_baithicuoiky/features/auth/login_page.dart';
import 'package:flutter_baithicuoiky/features/cart/cart_controller.dart';
import 'package:flutter_baithicuoiky/models/cart_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //APP BAR Ở ĐÂY:
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            backgroundColor: Colors.red,
            elevation: 4,
            centerTitle: true,

            // ICON BACK:
            leading: IconButton(
              icon: const Icon(
                Iconsax.arrow_left_2,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),

            // TITLE:
            title: const Text(
              "CHI TIẾT SẢN PHẨM",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),

            // GIỎ HÀNG
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Iconsax.shopping_cart,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),

                    // HIỂN THỊ SỐ LƯỢNG GIỎ HÀNG:
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: const Text(
                          "2",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //BODY Ở ĐÂY:
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            _buildImageSlider(product),
            _buildBasicInfo(product),
            _buildPriceInfo(product),
            buildActionButtons(context, product),
            _buildMetaInfo(product),
            _buildDescription(product),
            _buildSpecifications(product),
            _buildShippingWarranty(product),
            _buildReviews(product),
          ],
        ),
      ),
    );
  }
}

// HÌNH ẢNH:
Widget _buildImageSlider(product) {
  return SizedBox(
    height: 400,
    child: PageView.builder(
      itemCount: product.images.length,
      itemBuilder: (context, index) {
        return Image.network(product.images[index], fit: BoxFit.cover);
      },
    ),
  );
}

// TÊN + SAO + TRONG KHO + HÃNG:
Widget _buildBasicInfo(product) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),

        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 18),
            const SizedBox(width: 4),
            Text("${product.rating}"),
            const SizedBox(width: 12),
            Text(
              product.availabilityStatus,
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),

        const SizedBox(height: 6),
        Text(
          "Brand: ${product.brand}",
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}

// HIỂN THỊ GIÁ:
Widget _buildPriceInfo(product) {
  final discountedPrice =
      product.price * (1 - product.discountPercentage / 100);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: [
        Text(
          formatPrice(discountedPrice),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 8),
        if (product.discountPercentage > 0)
          Text(
            formatPrice(product.price),
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "-${product.discountPercentage.toStringAsFixed(0)}%",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

// HÀM TẠO NÚT ACTION DƯỚI GIÁ:
Widget buildActionButtons(BuildContext context, product) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    child: Row(
      children: [
        // NÚT TRẢ GÓP:
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.white, width: 2),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Chọn trả góp 0%!")));
            },
            child: const Text(
              "Trả góp 0%",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // NÚT MUA NGAY:
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.white, width: 2),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đi tới thanh toán!")),
              );
            },
            child: const Text(
              "Mua ngay",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // NÚT GIỎ HÀNG:
        SizedBox(
          width: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.white, width: 2),
              ),
            ),
            onPressed: () {
              // LẤY USER:
              final user = context.read<LoginController>().state.user;

              // USER NULL BẮT ĐĂNG NHẬP:
              if (user == null) {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).push(MaterialPageRoute(builder: (_) => const LoginPage()));
                return;
              }

              // NẾU ĐĂNG NHẬP RỒI THÌ THÊM VÀO:
              context.read<CartController>().addToCart(
                CartItem(
                  productId: product.id,
                  title: product.title,
                  price: product.price,
                  quantity: 1,
                  discountPercentage: product.discountPercentage,
                  total: product.price,
                  discountedTotal:
                      product.price * (1 - product.discountPercentage / 100),
                  thumbnail: product.thumbnail,
                ),
                user.id,
              );

              // THÔNG BÁO:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("THÊM VÀO GIỎ THÀNH CÔNG!")),
              );
            },
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    ),
  );
}

// CÁC THÔNG TIN CHI TIẾT:
Widget _buildMetaInfo(product) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        _chip("SKU: ${product.sku}"),
        _chip("Category: ${product.category}"),
        ...product.tags.map((e) => _chip(e)).toList(),
      ],
    ),
  );
}

Widget _chip(String text) {
  return Chip(
    label: Text(text, style: const TextStyle(fontSize: 12)),
    backgroundColor: Colors.grey.shade200,
  );
}

Widget _buildDescription(product) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mô tả sản phẩm",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          product.description,
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    ),
  );
}

Widget _buildSpecifications(product) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Thông số kỹ thuật",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _specRow("Cân nặng", "${product.weight} kg"),
        _specRow(
          "Kích thước",
          "${product.dimensions.width} x ${product.dimensions.height} x ${product.dimensions.depth} cm",
        ),
        _specRow("Tồn kho", product.stock.toString()),
        _specRow("Đặt tối thiểu", product.minimumOrderQuantity.toString()),
      ],
    ),
  );
}

Widget _specRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(label, style: const TextStyle(color: Colors.grey)),
        ),
        Text(value),
      ],
    ),
  );
}

Widget _buildShippingWarranty(product) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Chính sách",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        _policyRow(Icons.local_shipping, product.shippingInformation),
        _policyRow(Icons.verified, product.warrantyInformation),
        _policyRow(Icons.assignment_return, product.returnPolicy),
      ],
    ),
  );
}

Widget _policyRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.green),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

Widget _buildReviews(product) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Đánh giá",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...product.reviews.map((r) {
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(r.reviewerName),
              subtitle: Text(r.comment),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  Text(r.rating.toString()),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    ),
  );
}

// HÀM ĐỔI GIÁ ĐÔ SANG GIÁ VIỆT:
String formatPrice(double usdPrice, {double exchangeRate = 25000}) {
  double vndPrice = usdPrice * exchangeRate;
  return "${NumberFormat("#,##0", "vi_VN").format(vndPrice)}đ";
}
