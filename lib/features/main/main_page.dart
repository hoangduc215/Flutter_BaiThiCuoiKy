import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/cart/cart_page.dart';
import 'package:flutter_baithicuoiky/features/home/home_page.dart';
import 'package:flutter_baithicuoiky/features/profile/profile_page.dart';
import 'package:flutter_baithicuoiky/features/search/search_page.dart';
import 'package:flutter_baithicuoiky/features/store/store_page.dart';
import 'package:iconsax/iconsax.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildTabNavigator(
            HomePage(
              onBranOrKeywordSelected:
                  (String? brand, String? keyword, String? loai) {
                    setTabIndex(
                      1,
                      initialBrand: brand,
                      initialKeyword: keyword,
                      initialLoai: loai,
                    );
                  },
            ),
            0,
          ),
          _buildTabNavigator(
            SearchPage(
              initialBrand: null,
              initialKeyword: null,
              initialLoai: null,
            ),
            1,
          ),
          _buildTabNavigator(const StorePage(), 2),
          _buildTabNavigator(const CartPage(), 3),
          _buildTabNavigator(const ProfilePage(), 4),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  //BottomNavigationBar của app:
  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: false,
            onTap: (index) {
              if (_currentIndex == index) {
                _navigatorKeys[index].currentState?.popUntil(
                  (route) => route.isFirst,
                );
              } else {
                setState(() => _currentIndex = index);
              }
            },
            items: [
              _buildBottomItem(Iconsax.home, "Trang chủ", 0),
              _buildBottomItem(Iconsax.search_normal, "Tìm kiếm", 1),
              _buildBottomItem(Iconsax.map, "Cửa hàng", 2),
              _buildBottomItem(Iconsax.shopping_cart, "Giỏ hàng", 3),
              _buildBottomItem(Iconsax.profile_circle, "Tài khoản", 4),
            ],
          ),
        ),
      ),
    );
  }

  //Làm đẹp cho BottomNavigationBar:
  BottomNavigationBarItem _buildBottomItem(
    IconData icon,
    String label,
    int index,
  ) {
    final isActive = _currentIndex == index;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 3,
            width: isActive ? 16 : 0,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 4),
          Icon(
            icon,
            size: isActive ? 26 : 22,
            color: isActive ? Colors.red : Colors.grey,
          ),
        ],
      ),

      label: label,
    );
  }

  //Tạo Navigator cho từng tab BottomNavigationBar, mỗi tab có stack màn hình độc lập:
  Widget _buildTabNavigator(Widget rootPage, int index) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => rootPage);
      },
    );
  }

  //HÀM CHUYỂN TAB SEARCH:
  void setTabIndex(
    int index, {
    String? initialBrand,
    String? initialKeyword,
    String? initialLoai,
  }) {
    if (_currentIndex != index) {
      setState(() => _currentIndex = index);
    }

    if (index == 1) {
      _navigatorKeys[1].currentState?.push(
        MaterialPageRoute(
          builder: (_) => SearchPage(
            initialBrand: initialBrand,
            initialKeyword: initialKeyword,
            initialLoai: initialLoai,
          ),
        ),
      );
    }
  }
}
