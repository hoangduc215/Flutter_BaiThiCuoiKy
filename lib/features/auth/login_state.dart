import 'package:flutter_baithicuoiky/models/user_model.dart';

class LoginState {
  final bool isLoading;
  final String? error;
  final User? user;

  LoginState({required this.isLoading, this.error, this.user});

  factory LoginState.initial() {
    return LoginState(isLoading: false);
  }

  LoginState copyWith({bool? isLoading, String? error, User? user}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}
