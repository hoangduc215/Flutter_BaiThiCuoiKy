import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    //  Load dữ liệu nếu chưa load
    controller.loadAllProducts().then((_) {
      //  Lọc theo các từ khóa đã truyền
      controller.search(
        brand: widget.initialBrand,
        keyword: widget.initialKeyword,
        loai: widget.initialLoai,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<search.SearchController>(
        builder: (context, ctrl, _) {
          // LẤY STATE VÀ KIỂM TRA XEM CÓ LÕI KHÔNG:
          final state = ctrl.state;
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.error != null) {
            return Scaffold(body: Center(child: Text("Lỗi: ${state.error}")));
          }

          return Scaffold(
            appBar: AppBar(title: const Text("Kết quả tìm kiếm")),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Kết quả cho hãng: ${widget.initialBrand ?? 'Tất cả'}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Kết quả cho từ khóa: ${widget.initialKeyword ?? 'Tất cả'}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Kết quả cho loại: ${widget.initialLoai ?? 'Tất cả'}",
                    ),
                  ),
                  const Divider(),
                  // Hiển thị danh sách kết quả
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        final product = state.results[index];
                        return ListTile(
                          title: Text(product.title ?? "Tên sản phẩm trống"),
                          subtitle: Text(product.brand ?? ""),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
