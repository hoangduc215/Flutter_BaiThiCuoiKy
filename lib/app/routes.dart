import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/features/main/main_page.dart';

class AppRoutes {
  //TÊN ROUTES:
  static const main = '/';
  static const search = '/search';
  //MAP ROUTES:
  static final Map<String, WidgetBuilder> routes = {
    main: (context) => const MainPage(),
  };
}
