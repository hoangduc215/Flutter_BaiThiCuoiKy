import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/app/app.dart';
import 'package:flutter_baithicuoiky/core/services/api_service.dart';
import 'package:flutter_baithicuoiky/features/auth/login_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LoginController(api: ApiService())..tryAutoLogin(),
      child: const MyApp(),
    ),
  );
}
