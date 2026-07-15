import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Temporary delay
    // Later Firebase Auth Service will be called here.
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }
}