import 'package:flutter_baithicuoiky/models/user_model.dart';

class RegisterState {
  final bool isLoading;
  final User? user;
  final String? error;

  const RegisterState({this.isLoading = false, this.user, this.error});

  RegisterState copyWith({bool? isLoading, User? user, String? error}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      user: user,
      error: error,
    );
  }
}
