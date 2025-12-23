import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/core/services/api_service.dart';
import 'package:flutter_baithicuoiky/features/auth/login_state.dart';
import 'package:flutter_baithicuoiky/features/auth/token_storage.dart';
import 'package:flutter_baithicuoiky/models/login_response.dart';
import 'package:flutter_baithicuoiky/models/user_model.dart';

class LoginController extends ChangeNotifier {
  final ApiService api;

  LoginController({required this.api});
  LoginState _state = LoginState.initial();
  LoginState get state => _state;

  //LOGIN LẦN ĐẦU:
  Future<void> login(String username, String password) async {
    _setLoading();

    try {
      // LOGIN LẤY TOKEN:
      LoginResponse loginResponse = await api.login(username, password);

      // LƯU TOKEN:
      await TokenStorage.saveTokens(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
      );

      // DÙNG TOKEN LẤY USER:
      User user = await api.getUser(loginResponse.accessToken);

      // LOGIN THÀNH CÔNG:
      _state = _state.copyWith(isLoading: false, user: user, error: null);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }

  //LOGIN LẦN SAU TRONG MAIN.DART:
  Future<void> tryAutoLogin() async {
    final accessToken = await TokenStorage.getAccessToken();
    if (accessToken == null) return;

    _setLoading();

    try {
      final user = await api.getUser(accessToken);

      _state = _state.copyWith(isLoading: false, user: user, error: null);
    } catch (_) {
      await TokenStorage.clear();
      _state = LoginState.initial();
    }

    notifyListeners();
  }

  void _setLoading() {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();
  }

  //ĐĂNG XUẤT:
  Future<void> logout() async {
    await TokenStorage.clear();
    _state = LoginState.initial();
    notifyListeners();
  }
}
