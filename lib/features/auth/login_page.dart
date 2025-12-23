import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/auth/login_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xfff5f5f5),

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
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "HOANG DUC MOBILE",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),

      //BODY Ở ĐÂY:
      body: SafeArea(child: MyBody()),
    );
  }

  // LẤY THÔNG TIN TỪ KHUNG:
  final txtUser = TextEditingController();
  final txtPass = TextEditingController();

  //XÓA THÔNG TIN KHI ĐĂNG NHẬP XONG:
  @override
  void dispose() {
    txtUser.dispose();
    txtPass.dispose();
    super.dispose();
  }

  //KEY ĐỂ CHECK NHẤN NÚT ĐĂNG NHẬP CHƯA:
  final _formKey = GlobalKey<FormState>();

  // KEY ĐỂ ĐÓNG MỞ XEM MẬT KHẨU:
  bool _obscureText = true;

  //HÀM BODY:
  Widget MyBody() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ICON:
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.red, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Iconsax.shop5, color: Colors.red, size: 40),
                  ),
                ),
                const SizedBox(height: 25),

                /// GOOGLE VÀ FACEBOOK:
                Row(
                  children: [
                    Expanded(
                      child: _socialButton(
                        icon: FontAwesomeIcons.google,
                        text: 'Google',
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _socialButton(
                        icon: FontAwesomeIcons.facebookF,
                        text: 'Facebook',
                        color: const Color(0xff1877F2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                // CHỮ HOẶC:
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Hoặc đăng nhập bằng tài khoản',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 22),

                // TÀI KHOẢN:
                TextFormField(
                  controller: txtUser,
                  decoration: InputDecoration(
                    labelText: 'Tài khoản',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tài khoản';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // MẬT KHẨU:
                TextFormField(
                  controller: txtPass,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // QUÊN MẬT KHẨU:
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Quên mật khẩu?',
                      style: TextStyle(color: Color.fromARGB(255, 0, 75, 136)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // BUTTON ĐĂNG NHẬP:
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final controller = context.read<LoginController>();
                        try {
                          await controller.login(
                            txtUser.text.trim(),
                            txtPass.text.trim(),
                          );
                          if (!mounted) return;
                          if (controller.state.user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Đăng nhập thành công!')),
                            );
                            Navigator.pop(context);
                          } else if (controller.state.error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Sai tài khoản hoặc mật khẩu"),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Có lỗi xảy ra: $e')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'ĐĂNG NHẬP',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: color),
      label: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: BorderSide(color: color.withOpacity(0.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
