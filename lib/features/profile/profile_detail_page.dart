import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/auth/login_controller.dart';
import 'package:flutter_baithicuoiky/models/user_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // LẤY USER TỪ CONTROLLER:
    final user = context.watch<LoginController>().state.user!;

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
              "THÔNG TIN CÁ NHÂN",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),

            // NÚT BA CHẤM BÊN PHẢI:actions: [
            actions: [
              PopupMenuButton<_ProfileMenuAction>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                elevation: 6,
                offset: const Offset(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                onSelected: (value) {
                  switch (value) {
                    case _ProfileMenuAction.edit:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProfileDetailPage()),
                      );
                      break;

                    case _ProfileMenuAction.changePassword:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileDetailPage(),
                        ),
                      );
                      break;
                  }
                },
                itemBuilder: (context) => [
                  _popupItem(
                    icon: Icons.edit_outlined,
                    text: "Chỉnh sửa thông tin",
                    value: _ProfileMenuAction.edit,
                  ),
                  const PopupMenuDivider(height: 8),
                  _popupItem(
                    icon: Icons.lock_outline,
                    text: "Đổi mật khẩu",
                    value: _ProfileMenuAction.changePassword,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // BODY Ở ĐÂY:
      body: MyBody(user),
    );
  }

  // HÀM BODY:
  Widget MyBody(User user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 90, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileHeader(user),

          const SizedBox(height: 32),

          _buildCard(
            title: "Thông tin cá nhân",
            icon: Icons.person_outline,
            children: [
              _infoTile("Tuổi", "${user.age}", Icons.cake_outlined),
              _infoTile("Giới tính", user.gender, Icons.wc),
              _infoTile("Số điện thoại", user.phone, Icons.phone_outlined),
              _infoTile("Nhóm máu", user.bloodGroup, Icons.bloodtype_outlined),
            ],
          ),

          const SizedBox(height: 22),

          _buildCard(
            title: "Sức khỏe",
            icon: Icons.monitor_heart_outlined,
            children: [
              _infoTile("Chiều cao", "${user.height} cm", Icons.height),
              _infoTile("Cân nặng", "${user.weight} kg", Icons.scale_outlined),
            ],
          ),

          const SizedBox(height: 22),

          _buildCard(
            title: "Địa chỉ",
            icon: Icons.location_on_outlined,
            children: [
              Text(
                "${user.address.address}, ${user.address.city}, "
                "${user.address.state}, ${user.address.country}",
                style: const TextStyle(
                  fontSize: 15.5,
                  height: 1.5,
                  color: Color(0xFF374151),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          _buildCard(
            title: "Công ty",
            icon: Icons.work_outline,
            children: [
              _infoTile("Tên công ty", user.company.name, Icons.apartment),
              _infoTile(
                "Chức danh",
                "${user.company.title} · ${user.company.department}",
                Icons.badge_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // AVATAR, TÊN VÀ GMAIL:
  Widget _profileHeader(User user) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
            ),
            child: CircleAvatar(
              radius: 58,
              backgroundImage: NetworkImage(user.image),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "${user.firstName} ${user.lastName}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            user.email,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // THÔNG TIN TỪNG CARD:
  Widget _buildCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: Colors.red),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  // THÔNG TIN TỪNG CÁI:
  Widget _infoTile(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[500]),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14.5, color: Color(0xFF6B7280)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _ProfileMenuAction { edit, changePassword }

// TỪNG ITEM TRONG ĐỔI MẬT KHẨU VÀ CHỈNH SỬA THÔNG TIN:
PopupMenuItem<_ProfileMenuAction> _popupItem({
  required IconData icon,
  required String text,
  required _ProfileMenuAction value,
}) {
  return PopupMenuItem<_ProfileMenuAction>(
    value: value,
    height: 44,
    child: Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade800),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
