import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase_auth_service.dart';

class AppProvider extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  String? get errorMessage => _errorMessage;

  User? get currentUser => _authService.currentUser;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final User? user = await _authService.signup(
        name: name,
        email: email,
        password: password,
      );

      debugPrint('Signup successful: ${user?.email}');

      return user != null;
    } on FirebaseAuthException catch (e) {
      // Print real Firebase error in terminal
      debugPrint('Firebase Error Code: ${e.code}');
      debugPrint('Firebase Error Message: ${e.message}');

      _errorMessage = _getFirebaseErrorMessage(e.code);

      return false;
    } catch (e) {
      debugPrint('General Signup Error: $e');

      _errorMessage = 'Something went wrong: $e';

      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final User? user = await _authService.login(
        email: email,
        password: password,
      );

      debugPrint('Login successful: ${user?.email}');

      return user != null;
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Login Error Code: ${e.code}');
      debugPrint('Firebase Login Error Message: ${e.message}');

      _errorMessage = _getFirebaseErrorMessage(e.code);

      return false;
    } catch (e) {
      debugPrint('General Login Error: $e');

      _errorMessage = 'Something went wrong: $e';

      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      notifyListeners();
    } catch (e) {
      debugPrint('Logout Error: $e');
    }
  }

  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';

      case 'invalid-email':
        return 'Please enter a valid email address.';

      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';

      case 'operation-not-allowed':
        return 'Email/Password authentication is not enabled in Firebase.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
        return 'Incorrect password.';

      case 'invalid-credential':
        return 'Invalid email or password.';

      default:
        // Important: show actual Firebase error code
        return 'Authentication failed. Error: $code';
    }
  }
}