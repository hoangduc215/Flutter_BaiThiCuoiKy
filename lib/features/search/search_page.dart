import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final String? initialBrand;
  final String? initialKeyword;
  const SearchPage({super.key, this.initialBrand, this.initialKeyword});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Kết quả cho hãng: ${initialBrand ?? 'Tất cả'}"),
            Text("Kết quả cho từ khóa: ${initialKeyword ?? 'Tất cả'}"),
          ],
        ),
      ),
    );
  }
}
