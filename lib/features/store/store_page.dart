import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/store/store.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';

/// ===================== PAGE =====================
class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MapController _mapController = MapController();

  late final List<StoreLocation> stores;

  @override
  void initState() {
    super.initState();

    stores = [
      StoreLocation(
        name: 'Cửa hàng Huế',
        address: 'TP Huế',
        position: LatLng(16.459171983214713, 107.59246190864181),
      ),
      StoreLocation(
        name: 'Cửa hàng Đà Nẵng',
        address: 'Q. Hải Châu, Đà Nẵng',
        position: LatLng(16.054574949815127, 108.20231392439405),
      ),
      StoreLocation(
        name: 'Cửa hàng TP.HCM',
        address: 'Gò Vấp, TP.HCM',
        position: LatLng(10.821837634179934, 106.62507992504966),
      ),
      StoreLocation(
        name: 'Cửa hàng Hà Nội',
        address: 'Ba Đình, Hà Nội',
        position: LatLng(21.035032801458435, 105.8263943073787),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xfff5f5f5),

      // APP BAR Ở ĐÂY:
      appBar: buildSearchAppBar(scaffoldKey: _scaffoldKey),

      // BODY Ở ĐÂY:
      body: Stack(
        children: [
          /// ================= MAP =================
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: stores.first.position,
              initialZoom: 6,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.flutter_baithicuoiky',
              ),
              MarkerLayer(
                markers: stores.map((store) {
                  return Marker(
                    point: store.position,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          /// ================= BOTTOM SHEET =================
          buildStoreBottomSheet(
            stores: stores,
            mapController: _mapController,
            scaffoldKey: _scaffoldKey,
          ),
        ],
      ),

      // DRAWER THÔNG BÁO:
      endDrawer: buildNotificationDrawer(),
    );
  }
}

/// ===================== APP BAR =====================
PreferredSizeWidget buildSearchAppBar({
  required GlobalKey<ScaffoldState> scaffoldKey,
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
                      // NHẬP XONG ENTER:
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 27,
                        ),
                        hintText: "Tìm cửa hàng gần đây...",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        suffixIcon: "".isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {},
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

/// ===================== DANH SÁCH CỬA HÀNG =====================
Widget buildStoreBottomSheet({
  required List<StoreLocation> stores,
  required MapController mapController,
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  return DraggableScrollableSheet(
    initialChildSize: 0.18,
    minChildSize: 0.12,
    maxChildSize: 0.65,
    builder: (context, scrollController) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),

            /// ===== HANDLE =====
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(3),
              ),
            ),

            const SizedBox(height: 14),

            /// ===== HEADER =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.store_mall_directory,
                    color: Colors.red,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Danh sách cửa hàng',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${stores.length} địa điểm',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            const Divider(height: 1),

            /// ===== LIST STORE =====
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                itemCount: stores.length,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final store = stores[index];

                  return Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        mapController.move(store.position, 16);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            /// ICON
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 26,
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// TEXT
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    store.name,
                                    style: const TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    store.address,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
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
