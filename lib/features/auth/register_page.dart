import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/auth/login_controller.dart';
import 'package:flutter_baithicuoiky/features/auth/login_page.dart';
import 'package:flutter_baithicuoiky/features/auth/register_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      body: SafeArea(child: _buildBody()),
    );
  }

  // LẤY THÔNG TIN TỪ KHUNG:
  final txtUser = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPass = TextEditingController();
  final txtConfirmPass = TextEditingController();

  //XÓA THÔNG TIN KHI ĐĂNG NHẬP XONG:
  @override
  void dispose() {
    txtUser.dispose();
    txtEmail.dispose();
    txtPass.dispose();
    txtConfirmPass.dispose();
    super.dispose();
  }

  //KEY ĐỂ CHECK NHẤN NÚT ĐĂNG NHẬP CHƯA:
  final _formKey = GlobalKey<FormState>();

  // KEY ĐỂ ĐÓNG MỞ XEM MẬT KHẨU:
  bool _obscurePass = true;
  bool _obscureConfirmPass = true;

  //Hàm body:
  Widget _buildBody() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(28),
            child: Column(
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

                /// GOOGLE & FACEBOOK
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

                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Hoặc đăng ký bằng tài khoản',
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

                // USERNAME
                TextFormField(
                  controller: txtUser,
                  decoration: InputDecoration(
                    labelText: 'Tên tài khoản',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tên tài khoản';
                    }

                    final username = value.trim();
                    final regex = RegExp(r'^[a-zA-Z0-9_]{4,20}$');

                    if (!regex.hasMatch(username)) {
                      return 'Tên tài khoản gồm chữ, số, _ (4–20 ký tự)';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // EMAIL
                TextFormField(
                  controller: txtEmail,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    if (!value.contains('@')) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // PASSWORD
                TextFormField(
                  controller: txtPass,
                  obscureText: _obscurePass,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => _obscurePass = !_obscurePass);
                      },
                      icon: Icon(
                        _obscurePass ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  validator: (value) =>
                      value!.length < 6 ? 'Mật khẩu tối thiểu 6 ký tự' : null,
                ),
                const SizedBox(height: 18),

                // CONFIRM PASSWORD
                TextFormField(
                  controller: txtConfirmPass,
                  obscureText: _obscureConfirmPass,
                  decoration: InputDecoration(
                    labelText: 'Xác nhận mật khẩu',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () => _obscureConfirmPass = !_obscureConfirmPass,
                        );
                      },
                      icon: Icon(
                        _obscureConfirmPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != txtPass.text) {
                      return 'Mật khẩu không khớp';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // REGISTER BUTTON
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final registerController = context
                            .read<RegisterController>();
                        final loginController = context.read<LoginController>();
                        try {
                          await registerController.register(
                            username: txtUser.text.trim(),
                            email: txtEmail.text.trim(),
                            password: txtPass.text.trim(),
                          );
                          if (!mounted) return;
                          if (registerController.state.user != null) {
                            // 👉 FAKE LOGIN NGAY SAU KHI ĐĂNG KÝ
                            loginController.fakeLogin(
                              registerController.state.user!,
                            );

                            // THÔNG BÁO ĐĂNG KÝ THÀNH CÔNG
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 64,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Đăng ký thành công',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Chào mừng bạn đến với hệ thống',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                            Future.delayed(
                              const Duration(milliseconds: 1500),
                              () {
                                if (!mounted) return;
                                Navigator.of(context).pop(); // đóng dialog
                                Navigator.of(
                                  context,
                                ).pop(); // quay về Home / màn trước
                              },
                            );
                          } else if (registerController.state.error != null) {
                            final error = registerController.state.error;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Đăng ký thất bại: $error'),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                            // THÔNG BÁO ĐĂNG KÝ THẤT BẠI
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 64,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Đăng ký thất bại',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Không thể tạo tài khoản ',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                            Future.delayed(
                              const Duration(milliseconds: 1500),
                              () {
                                if (!mounted) return;
                                Navigator.of(context).pop();
                              },
                            );
                          }
                        } catch (e) {
                          // LỖI API
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 64,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Đăng ký thất bại',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Có lỗi xảy ra: $e',
                                    style: const TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );

                          Future.delayed(
                            const Duration(milliseconds: 1500),
                            () {
                              if (!mounted) return;
                              Navigator.of(context).pop();
                            },
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
                      'ĐĂNG KÝ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // LINK NHẤN SANG TRANG ĐĂNG KÝ:
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Đã có tài khoản? ',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Đăng nhập ngay',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginPage(),
                                ),
                              );
                            },
                        ),
                      ],
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
