import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/product/product_detail_page.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:flutter_baithicuoiky/features/search/search_controller.dart'
    as search;

class SearchPage extends StatefulWidget {
  final String? initialBrand;
  final String? initialKeyword;
  final String? initialLoai;
  const SearchPage({
    super.key,
    this.initialBrand,
    this.initialKeyword,
    this.initialLoai,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // LẤY CONTROLLER TỪ SearchController:
  final search.SearchController controller = search.SearchController();

  // TẠO ĐỐI TƯỢNG ĐỂ LẤY THÔNG TIN NHẬP VÀO:
  final TextEditingController keyword = TextEditingController();

  // TẠO ĐỐI TƯỢNG ĐỂ LÀM CHO THONG BÁO:
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 2 LOẠI  SAU KHI CHỌN, VÌ LOẠI BAN ĐẦU LÀ KHÔNG THAY ĐỔI:
  String? selectedBrand;
  String? selectedLoai;

  // CÁC HÃNG:
  final brands = [
    {"name": "Tất cả", "image": null},
    {"name": "Apple", "image": "assets/icon/apple.png"},
    {"name": "Oppo", "image": "assets/icon/oppo.png"},
    {"name": "Realme", "image": "assets/icon/realme.png"},
    {"name": "Samsung", "image": "assets/icon/samsung.png"},
    {"name": "Vivo", "image": "assets/icon/vivo.png"},
  ];

  // LOẠI:
  final loais = [
    {"name": "Tất cả", "value": "Tất cả"},
    {"name": "Điện thoại", "value": "DienThoai"},
    {"name": "Phụ kiện", "value": "PhuKien"},
  ];

  // BIẾN ĐỂ HIỆN 10 SẢN PHẨM:
  int visibleCount = 10;

  @override
  void dispose() {
    keyword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // LẤY HÃNG BAN ĐẦU:
    selectedBrand = widget.initialBrand;
    selectedLoai = widget.initialLoai;

    // NẾU CÓ KEY WORD BAN ĐẦU THÌ HIỂN THỊ TRONG THANH TÌM KIẾM:
    if (widget.initialKeyword != null &&
        widget.initialKeyword!.trim().isNotEmpty) {
      keyword.text = widget.initialKeyword!;
    }

    //  Load dữ liệu nếu chưa load
    controller.loadAllProducts().then((_) {
      //  Lọc theo các từ khóa đã truyền
      controller.search(
        brand: widget.initialBrand,
        keyword: widget.initialKeyword,
        loai: widget.initialLoai,
      );
      visibleCount = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<search.SearchController>(
        builder: (context, controller, _) {
          // LẤY STATE VÀ KIỂM TRA XEM CÓ LÕI KHÔNG:
          final state = controller.state;
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.error != null) {
            return Scaffold(body: Center(child: Text("Lỗi: ${state.error}")));
          }

          // SCAFFOLD Ở ĐÂY:
          return Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            backgroundColor: const Color(0xfff5f5f5),

            //APP BAR Ở ĐÂY:
            appBar: buildSearchAppBar(
              context: context,
              keyword: keyword,
              controller: controller,
              scaffoldKey: _scaffoldKey,
              selectedBrand: selectedBrand,
              selectedLoai: selectedLoai,
            ),

            // BODY Ở ĐÂY:
            body: buildSearchBody(
              products: state.results,
              selectedBrand: selectedBrand,
              selectedLoai: selectedLoai,
              brands: brands,
              loais: loais,
              keyword: keyword,
              controller: controller,
              visibleCount: visibleCount,

              // HÀM THÊM 10 SẢN PHẨM TRUYỀN CHO buildSearchBody:
              onLoadMore: () {
                setState(() {
                  visibleCount += 10;
                });
              },

              // HÀM CHỌN HÃNG TRUYỀN CHO buildSearchBody:
              onBrandChanged: (brand) {
                setState(() {
                  selectedBrand = brand;
                  visibleCount = 10;
                });
              },

              // HÀM CHỌN LOẠI TRUYỀN CHO buildSearchBody:
              onLoaiChanged: (loai) {
                setState(() {
                  selectedLoai = loai;
                  visibleCount = 10;
                });
              },
            ),

            // DRAWER THÔNG BÁO:
            endDrawer: buildNotificationDrawer(),
          );
        },
      ),
    );
  }
}

//  ----------------------------------- HÀM APP BAR Ở ĐÂY:  -------------------------------
PreferredSizeWidget buildSearchAppBar({
  required BuildContext context,
  required TextEditingController keyword,
  required search.SearchController controller,
  required GlobalKey<ScaffoldState> scaffoldKey,
  String? selectedBrand,
  String? selectedLoai,
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: Container(
        color: Colors.red,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Row(
              children: [
                const SizedBox(width: 15),

                // ICON SHOP:
                const Icon(Iconsax.shop5, color: Colors.white, size: 32),
                const SizedBox(width: 12),

                // THANH TÌM KIẾM:
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: TextFormField(
                      controller: keyword,
                      // NHẬP XONG ENTER:
                      onFieldSubmitted: (value) {
                        controller.search(
                          keyword: value.trim(),
                          brand: selectedBrand,
                          loai: selectedLoai,
                        );
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 27,
                        ),
                        hintText: "Tìm điện thoại, phụ kiện...",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        suffixIcon: keyword.text.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  keyword.clear();
                                  controller.search(
                                    keyword: null,
                                    brand: selectedBrand,
                                    loai: selectedLoai,
                                  );
                                },
                              ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ),

                // ICON THÔNG BÁO:
                IconButton(
                  icon: const Icon(
                    Iconsax.notification5,
                    color: Colors.white,
                    size: 32,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),

                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ------------------------------------ HÀM BODY Ở ĐÂY: -----------------------------------
Widget buildSearchBody({
  required List products,
  required String? selectedBrand,
  required String? selectedLoai,
  required List brands,
  required List loais,
  required TextEditingController keyword,
  required search.SearchController controller,
  required Function(String?) onBrandChanged,
  required Function(String?) onLoaiChanged,
  required int visibleCount,
  required VoidCallback onLoadMore,
}) {
  return SafeArea(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // COMBOBOX CHỌN HÃNG:
              Expanded(
                child: DropdownButtonFormField<String?>(
                  value: selectedBrand ?? "Tất cả",

                  // LÀM ĐẸP CHO COMBOBOX:
                  decoration: InputDecoration(
                    labelText: "Hãng",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.blue.shade400,
                        width: 1.6,
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  items: brands.map((b) {
                    final image = b["image"];
                    final name = b["name"];
                    return DropdownMenuItem<String?>(
                      value: name,
                      child: Row(
                        children: [
                          if (image != null)
                            Image.asset(image, width: 20, height: 20)
                          else
                            const Icon(Icons.all_inclusive, size: 20),
                          const SizedBox(width: 10),
                          Text(name, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),

                  // KHI CHỌN SẼ SUBMIT:
                  onChanged: (value) {
                    final brand = value == "Tất cả" ? null : value;
                    onBrandChanged(brand);
                    controller.search(
                      brand: brand,
                      loai: selectedLoai,
                      keyword: keyword.text.trim(),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              // COMBOBOX CHỌN LOẠI:
              Expanded(
                child: DropdownButtonFormField<String?>(
                  value: selectedLoai ?? "Tất cả",

                  // LÀM ĐẸP CHO COMBOBOX:
                  decoration: InputDecoration(
                    labelText: "Loại",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.blue.shade400,
                        width: 1.6,
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  items: loais.map((l) {
                    IconData icon;
                    switch (l["value"]) {
                      case "DienThoai":
                        icon = Icons.smartphone;
                        break;
                      case "PhuKien":
                        icon = Icons.headphones;
                        break;
                      default:
                        icon = Icons.apps;
                    }
                    return DropdownMenuItem<String?>(
                      value: l["value"],
                      child: Row(
                        children: [
                          Icon(icon, size: 20),
                          const SizedBox(width: 10),
                          Text(l["name"], style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),

                  // KHI ẤN THÌ SUBMIT:
                  onChanged: (value) {
                    final loai = value == "Tất cả" ? null : value;
                    onLoaiChanged(loai);
                    controller.search(
                      brand: selectedBrand,
                      loai: loai,
                      keyword: keyword.text.trim(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        const Divider(),

        // DANH SÁCH SẢN PHẨM:
        Expanded(
          child: products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.search_off, size: 80, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                        "Không có sản phẩm mong đợi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    // DANH SÁCH SẢN PHẨM:
                    SliverPadding(
                      padding: const EdgeInsets.all(12),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = products[index];
                            return _ProductGridItem(product: product);
                          },
                          childCount: visibleCount > products.length
                              ? products.length
                              : visibleCount,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.65,
                            ),
                      ),
                    ),

                    // ===== NÚT XEM THÊM =====
                    if (visibleCount < products.length)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: ElevatedButton.icon(
                              onPressed: onLoadMore,
                              icon: const Icon(Icons.expand_more, size: 20),
                              label: const Text("Xem thêm"),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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

// HÀM HIỂN THỊ TỪNG ITEM:
class _ProductGridItem extends StatelessWidget {
  final product;
  const _ProductGridItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProductDetailPage(product: product),
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (_, animation, secondaryAnimation, child) {
              final scaleAnimation = Tween<double>(begin: 0.9, end: 1.0)
                  .animate(
                    CurvedAnimation(parent: animation, curve: Curves.linear),
                  );
              final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.linear),
              );

              return FadeTransition(
                opacity: fadeAnimation,
                child: ScaleTransition(scale: scaleAnimation, child: child),
              );
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 1),
                        );
                      },
                    ),
                  ),
                ),
                const Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(Icons.favorite_border, color: Colors.red),
                ),
                if (product.discountPercentage > 0)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "-${product.discountPercentage.toStringAsFixed(0)}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        formatPrice(product.price),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
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
  }
}

// ------------------------------------ HÀM DRAWER Ở ĐÂY: ---------------------------------
Widget buildNotificationDrawer() {
  return Drawer(
    width: 340,
    child: SafeArea(
      child: Column(
        children: [
          // ================= HEADER FILTER =================
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: const [
                Icon(Icons.notifications, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Thông báo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: const [
                _NotifyFilterChip(text: 'Tất cả', selected: true),
                SizedBox(width: 8),
                _NotifyFilterChip(text: 'Chưa xem'),
                SizedBox(width: 8),
                _NotifyFilterChip(text: 'Đã xem'),
              ],
            ),
          ),

          const SizedBox(height: 8),
          const Divider(height: 1),

          // ================= LIST THÔNG BÁO =================
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _notificationItem(
                  icon: Icons.shopping_bag_outlined,
                  color: Colors.blue,
                  title: 'Đơn hàng đã được xác nhận',
                  subtitle: 'Mã đơn #DH123456',
                  time: '2 phút trước',
                  isUnread: true,
                ),
                _notificationItem(
                  icon: Icons.local_shipping_outlined,
                  color: Colors.orange,
                  title: 'Đơn hàng đang giao',
                  subtitle: 'Dự kiến giao hôm nay',
                  time: '1 giờ trước',
                  isUnread: true,
                ),
                _notificationItem(
                  icon: Icons.discount_outlined,
                  color: Colors.red,
                  title: 'Ưu đãi 20% cho phụ kiện',
                  subtitle: 'Áp dụng đến 30/09',
                  time: 'Hôm qua',
                ),
                _notificationItem(
                  icon: Icons.card_giftcard_outlined,
                  color: Colors.purple,
                  title: 'Voucher 50.000đ',
                  subtitle: 'Dành riêng cho bạn',
                  time: '2 ngày trước',
                ),
                _notificationItem(
                  icon: Icons.security_outlined,
                  color: Colors.grey,
                  title: 'Đăng nhập từ thiết bị mới',
                  subtitle: 'Vị trí: TP.HCM',
                  time: '3 ngày trước',
                ),
                _notificationItem(
                  icon: Icons.price_change_outlined,
                  color: Colors.green,
                  title: 'Giá sản phẩm đã giảm',
                  subtitle: 'iPhone 15 giảm 5%',
                  time: '3 ngày trước',
                ),
                _notificationItem(
                  icon: Icons.payment_outlined,
                  color: Colors.teal,
                  title: 'Thanh toán thành công',
                  subtitle: 'Số tiền 12.500.000đ',
                  time: '4 ngày trước',
                ),
                _notificationItem(
                  icon: Icons.star_outline,
                  color: Colors.amber,
                  title: 'Đánh giá sản phẩm',
                  subtitle: 'Hãy đánh giá đơn hàng của bạn',
                  time: '5 ngày trước',
                ),
                _notificationItem(
                  icon: Icons.support_agent_outlined,
                  color: Colors.indigo,
                  title: 'Hỗ trợ khách hàng',
                  subtitle: 'Chúng tôi đã phản hồi yêu cầu của bạn',
                  time: '6 ngày trước',
                ),
                _notificationItem(
                  icon: Icons.lock_outline,
                  color: Colors.grey,
                  title: 'Bạn vừa đổi mật khẩu',
                  subtitle: 'Nếu không phải bạn, hãy liên hệ ngay',
                  time: '1 tuần trước',
                ),

                // ===== LẶP THÊM ĐỂ SCROLL DÀI =====
                _notificationItem(
                  icon: Icons.notifications_none,
                  color: Colors.blueGrey,
                  title: 'Thông báo hệ thống',
                  subtitle: 'Cập nhật điều khoản sử dụng',
                  time: '1 tuần trước',
                ),
                _notificationItem(
                  icon: Icons.update,
                  color: Colors.deepOrange,
                  title: 'Ứng dụng có phiên bản mới',
                  subtitle: 'Cập nhật để trải nghiệm tốt hơn',
                  time: '2 tuần trước',
                ),
                _notificationItem(
                  icon: Icons.recommend_outlined,
                  color: Colors.pink,
                  title: 'Gợi ý sản phẩm cho bạn',
                  subtitle: 'Dựa trên lịch sử mua hàng',
                  time: '2 tuần trước',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// HÀM THÔNG BÁO:
Widget _notificationItem({
  required IconData icon,
  required Color color,
  required String title,
  required String subtitle,
  required String time,
  bool isUnread = false,
}) {
  return Container(
    color: isUnread ? Colors.red.withOpacity(0.05) : null,
    child: ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: color.withOpacity(0.15),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isUnread ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          const SizedBox(height: 2),
          Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
      onTap: () {},
    ),
  );
}

// LỰA CHỌN LOẠI THÔNG BÁO:
class _NotifyFilterChip extends StatelessWidget {
  final String text;
  final bool selected;

  const _NotifyFilterChip({required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.red : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
