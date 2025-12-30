import 'package:flutter/material.dart';
import 'package:flutter_baithicuoiky/core/services/api_service.dart';
import 'package:flutter_baithicuoiky/features/auth/register_state.dart';

class RegisterController extends ChangeNotifier {
  final ApiService api;

  RegisterController({required this.api});

  RegisterState _state = const RegisterState();
  RegisterState get state => _state;

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    _state = _state.copyWith(isLoading: true, error: null, user: null);
    notifyListeners();

    try {
      final user = await api.register(
        username: username,
        email: email,
        password: password,
      );

      _state = _state.copyWith(isLoading: false, user: user);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }

  void reset() {
    _state = const RegisterState();
    notifyListeners();
  }
}
