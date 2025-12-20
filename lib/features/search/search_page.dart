import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final String? initialBrand;
  const SearchPage({super.key, this.initialBrand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Kết quả cho: ${initialBrand ?? 'Tất cả'}")),
    );
  }
}
