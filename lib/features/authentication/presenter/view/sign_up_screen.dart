import 'package:flutter/material.dart';
import 'package:saffar_app/features/authentication/presenter/view/sign_in_screen.dart';

import '../../../../core/constants/nums.dart';
import '../../../../core/palette.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const String routeName = '/sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  void _switchPasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _switchConfirmPasswordVisibility() {
    setState(() {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Nums.horizontalPadding),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // TODO: Saffar logo
              const Text(
                'Saffar',
                style: TextStyle(
                  fontSize: 48,
                  color: Palette.primary,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 32),

              // Name text form field
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                  border: Theme.of(context).inputDecorationTheme.border,
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.enabledBorder,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                  errorBorder:
                      Theme.of(context).inputDecorationTheme.errorBorder,
                ),
              ),
              const SizedBox(height: 16),

              // Email text form field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                  border: Theme.of(context).inputDecorationTheme.border,
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.enabledBorder,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                  errorBorder:
                      Theme.of(context).inputDecorationTheme.errorBorder,
                ),
              ),
              const SizedBox(height: 16),

              // Password text form field
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                  border: Theme.of(context).inputDecorationTheme.border,
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.enabledBorder,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                  errorBorder:
                      Theme.of(context).inputDecorationTheme.errorBorder,
                  suffixIcon: InkWell(
                    onTap: () {
                      _switchPasswordVisibility();
                    },
                    child: !_passwordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Confirm password text form field
              TextFormField(
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_confirmPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                  border: Theme.of(context).inputDecorationTheme.border,
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.enabledBorder,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                  errorBorder:
                      Theme.of(context).inputDecorationTheme.errorBorder,
                  suffixIcon: InkWell(
                    onTap: () {
                      _switchConfirmPasswordVisibility();
                    },
                    child: !_passwordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Sign up button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Center(
                  child: Text(
                    'Sign Up',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Or
              const Text('Or'),

              // Sign in button
              TextButton(
                onPressed: () {
                  // Navigates to sign in screen while replacing the current
                  // screen with sign in screen
                  Navigator.pushReplacementNamed(context, SignInScreen.routeName);
                },
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Center(child: Text('Sign In')),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
