import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/home/home_controller.dart';
import 'package:flutter_baithicuoiky/features/product/product_detail_page.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final void Function(String? brand, String? keyword) onBranOrKeywordSelected;
  const HomePage({super.key, required this.onBranOrKeywordSelected});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController()..loadProducts(),
      child: _HomeView(onBranOrKeywordSelected: onBranOrKeywordSelected),
    );
  }
}

class _HomeView extends StatefulWidget {
  final void Function(String? brand, String? keyword) onBranOrKeywordSelected;
  const _HomeView({required this.onBranOrKeywordSelected});

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brands = [
      {"name": "Apple", "image": "assets/icon/apple.png"},
      {"name": "Oppo", "image": "assets/icon/oppo.png"},
      {"name": "Realme", "image": "assets/icon/realme.png"},
      {"name": "Samsung", "image": "assets/icon/samsung.png"},
      {"name": "Vivo", "image": "assets/icon/vivo.png"},
    ];

    final state = context.watch<HomeController>().state;
    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (state.error != null) {
      return Scaffold(body: Center(child: Text("Lỗi: ${state.error}")));
    }

    return Scaffold(
      //LÀM CHO APP BAR ĐÈ LÊN BODY:
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xfff5f5f5),

      //APP BAR Ở ĐÂY:
      appBar: PreferredSize(
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
                          controller: _controller,
                          onFieldSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              widget.onBranOrKeywordSelected(
                                null,
                                value.trim(),
                              );
                            }
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
                            suffixIcon: _controller.text.isEmpty
                                ? null
                                : IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      size: 27,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _controller.clear();
                                      setState(() {});
                                    },
                                  ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ),

                    //ICON THÔNG BÁO:
                    IconButton(
                      icon: const Icon(
                        Iconsax.notification5,
                        color: Colors.white,
                        size: 32,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                    ),

                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      //BODY Ở ĐÂY:
      body: RefreshIndicator(
        onRefresh: () => context.read<HomeController>().loadProducts(),
        child: CustomScrollView(
          slivers: [
            //CHỪA CHỖ CHO APP BAR:
            const SliverToBoxAdapter(child: SizedBox(height: 95)),

            // BANNER Ở ĐÂY:
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 5,
                    child: Image.asset(
                      "assets/images/banner.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // DANH SÁCH BRAND:
            SliverToBoxAdapter(
              child: Center(
                child: SizedBox(
                  height: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      children: brands.map((brand) {
                        double logoSize = 60;
                        return GestureDetector(
                          onTap: () {
                            widget.onBranOrKeywordSelected(
                              brand['name'] as String,
                              null,
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: logoSize,
                                height: logoSize,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    logoSize / 2,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    logoSize / 2,
                                  ),
                                  child: Image.asset(
                                    brand['image'] as String,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                brand['name'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // DANH SÁCH ĐIỆN THOẠI NỔI BẬT:
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "DANH SÁCH ĐIỆN THOẠI NỔI BẬT",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Xem tất cả",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _HorizontalProductGrid(products: state.phones),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // DANH SÁCH PHỤ KIỆN NỔI BẬT
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "DANH SÁCH PHỤ KIỆN NỔI BẬT",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Xem tất cả",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _HorizontalProductGrid(products: state.accessories),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
          ],
        ),
      ),
    );
  }
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

// GRID VIEW KÉO NGANG 2 HÀNG:
class _HorizontalProductGrid extends StatelessWidget {
  final List products;
  const _HorizontalProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 710,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 260,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return _ProductGridItem(product: product);
        },
      ),
    );
  }
}

// HÀM ĐỔI GIÁ ĐÔ SANG GIÁ VIỆT:
String formatPrice(double usdPrice, {double exchangeRate = 25000}) {
  double vndPrice = usdPrice * exchangeRate;
  return "${NumberFormat("#,##0", "vi_VN").format(vndPrice)}đ";
}
