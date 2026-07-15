import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final appProvider = context.read<AppProvider>();

    await appProvider.signup(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully'),
      ),
    );

    // Go back to login screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    'Join FindIt and help reconnect lost items',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // Name
                const Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: 'Enter your full name',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }

                    if (value.trim().length < 3) {
                      return 'Name must be at least 3 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Email
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Password
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Consumer<AppProvider>(
                  builder: (context, provider, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: !provider.isPasswordVisible,

                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),

                        suffixIcon: IconButton(
                          onPressed: provider.togglePasswordVisibility,
                          icon: Icon(
                            provider.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }

                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }

                        return null;
                      },
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Confirm Password
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Consumer<AppProvider>(
                  builder: (context, provider, child) {
                    return TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !provider.isConfirmPasswordVisible,

                      decoration: InputDecoration(
                        hintText: 'Confirm your password',
                        prefixIcon: const Icon(Icons.lock_outline),

                        suffixIcon: IconButton(
                          onPressed:
                              provider.toggleConfirmPasswordVisibility,
                          icon: Icon(
                            provider.isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }

                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }

                        return null;
                      },
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Signup Button
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: Consumer<AppProvider>(
                    builder: (context, provider, child) {
                      return ElevatedButton(
                        onPressed: provider.isLoading
                            ? null
                            : _handleSignup,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C4EFF),
                          foregroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        child: provider.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text('Already have an account?'),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF6C4EFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}