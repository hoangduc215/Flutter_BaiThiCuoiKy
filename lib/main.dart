import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/app/app.dart';
import 'package:flutter_baithicuoiky/core/services/api_service.dart';
import 'package:flutter_baithicuoiky/features/auth/login_controller.dart';
import 'package:flutter_baithicuoiky/features/auth/register_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginController(api: ApiService())..tryAutoLogin(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterController(api: ApiService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
