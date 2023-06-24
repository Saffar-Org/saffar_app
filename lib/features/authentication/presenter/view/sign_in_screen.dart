import 'package:flutter/material.dart';
import 'package:saffar_app/core/constants/nums.dart';

import '../../../../core/palette.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const String routeName = '/sign_in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _passwordVisible = false;

  void _switchPasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

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

              // Email text form field
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
              const SizedBox(height: 32),

              // Sign in button
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
                    'Sign In',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Or
              const Text('Or'),

              // Sign up button
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Center(child: Text('Sign Up')),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
