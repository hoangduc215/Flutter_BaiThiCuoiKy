import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/auth/login_controller.dart';
import 'package:flutter_baithicuoiky/features/auth/login_page.dart';
import 'package:flutter_baithicuoiky/features/auth/register_page.dart';
import 'package:flutter_baithicuoiky/features/cart/cart_controller.dart';
import 'package:flutter_baithicuoiky/features/profile/profile_detail_page.dart';
import 'package:flutter_baithicuoiky/models/user_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<LoginController>().state.user;

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      //BODY Ở ĐÂY:
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _WelcomeCard(),
              SizedBox(height: 12),
              _QuickActions(),
              SizedBox(height: 12),
              _Section(
                title: 'Lịch sử',
                items: [
                  _Item('Lịch sử mua hàng', Icons.receipt_long),
                  _Item('Tra cứu bảo hành', Icons.verified_user),
                ],
              ),
              _Section(
                title: 'Ưu đãi',
                items: [
                  _Item('Hạng thành viên', Icons.workspace_premium),
                  _Item('Mã giảm giá', Icons.local_offer),
                  _Item('S-Edu', Icons.school),
                ],
              ),
              _Section(
                title: 'Tài khoản',
                items: [
                  _Item(
                    'Thông tin cá nhân',
                    Icons.person,
                    onTap: () async {
                      final user = context.read<LoginController>().state.user;

                      // CHƯA ĐĂNG NHẬP
                      if (user == null) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                        return;
                      } else {
                        // ĐÃ ĐĂNG NHẬP VÀO DETAIL
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (_) => const ProfileDetailPage(),
                          ),
                        );
                      }
                    },
                  ),
                  _Item('Sổ địa chỉ', Icons.location_on),
                  _Item('Liên kết tài khoản', Icons.link),
                ],
              ),
              if (user != null) const _LogoutSection(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// TÊN DÒNG WELCOME:
class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    // LẤY USER TỪ STATE NẾU TỒN TẠI:
    final loginState = context.watch<LoginController>().state;
    final User? user = loginState.user;

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // NẾU ĐĂNG NHẬP RỒI THÌ HIỂN THỊ ẢNH, KHÔNG THÌ HIỂN THỊ ICON:
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xfffce4ec),
            backgroundImage: user != null ? NetworkImage(user.image) : null,
            child: user == null
                ? const Icon(Icons.person, color: Colors.red)
                : null,
          ),
          const SizedBox(width: 12),

          // NẾU ĐĂNG NHẬP RỒI THÌ HIỂN THỊ TÊN VÀ GMAIL, KHÔNG THÌ HIỂN THỊ CHÀO MỪNG....
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user != null
                      ? 'Xin chào, ${user.firstName} ${user.lastName}'
                      : 'Chào mừng bạn đến với Hoang Duc Mobile',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  user != null ? user.email : 'Đăng nhập để nhận nhiều ưu đãi',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          // NÚT ĐĂNG NHẬP VÀ ĐĂNG KÝ VÀ ĐĂNG XUẤT:
          Column(
            children: [
              if (user == null) ...[
                SizedBox(
                  width: 120,
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 120,
                  height: 36,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ICON HẠNG TV, MÃ GIẢM, ĐƠN HÀNG...
class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _QuickItem(Icons.workspace_premium, 'Hạng TV'),
          _QuickItem(Icons.local_offer, 'Mã giảm'),
          _QuickItem(Icons.receipt_long, 'Đơn hàng'),
          _QuickItem(Icons.school, 'S-Student'),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<_Item> items;

  const _Section({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ...items.map(
            (e) => ListTile(
              leading: Icon(e.icon),
              title: Text(e.title),
              trailing: const Icon(Icons.chevron_right),
              onTap: e.onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _Item {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const _Item(this.title, this.icon, {this.onTap});
}

class _QuickItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickItem(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.red),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// HÀM ĐĂNG XUẤT:
class _LogoutSection extends StatelessWidget {
  const _LogoutSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text(
          'Đăng xuất',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          final ok = await showDialog<bool>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text('Đăng xuất'),
              content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: const Text('Hủy'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, true),
                  child: const Text('Đăng xuất'),
                ),
              ],
            ),
          );

          if (ok == true) {
            context.read<LoginController>().logout();
            context.read<CartController>().clear();
          }
        },
      ),
    );
  }
}
