import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saffar_app/features/authentication/presenter/cubits/auth_cubit.dart';

import '../../../../core/constants/nums.dart';
import '../../../../core/palette.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const String routeName = '/sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final AuthCubit _authCubit;

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final GlobalKey<FormState> _formKey;

  late final List<FocusNode> _focusNodes;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  /// Switches password visibility from true to false
  /// and vice versa and [setState]'s it.
  void _switchPasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  /// Switches confirm password visibility from true to false
  /// and vice versa and [setState]'s it.
  void _switchConfirmPasswordVisibility() {
    setState(() {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    });
  }

  /// Unfocuses the keyboard, validates the form
  /// then sign up function in called.
  void _onSignUpButtonPressed() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String phone = _phoneController.text;
      final String password = _passwordController.text;

      _authCubit.signUpGetUserAndTokenAndEmitThem(
        context,
        name,
        phone,
        password,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _authCubit = context.read<AuthCubit>();

    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _formKey = GlobalKey<FormState>();

    _focusNodes = List.generate(4, (index) => FocusNode());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return !state.loading;
          },
          child: Scaffold(
            body: SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Nums.horizontalPadding),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
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
                          validator: (name) {
                            return _authCubit.validateName(name);
                          },
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          focusNode: _focusNodes[0],
                          onEditingComplete: () {
                            _focusNodes[0].unfocus();
                            _focusNodes[1].requestFocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Name',
                            border:
                                Theme.of(context).inputDecorationTheme.border,
                            enabledBorder: Theme.of(context)
                                .inputDecorationTheme
                                .enabledBorder,
                            focusedBorder: Theme.of(context)
                                .inputDecorationTheme
                                .focusedBorder,
                            errorBorder: Theme.of(context)
                                .inputDecorationTheme
                                .errorBorder,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Phone text form field
                        TextFormField(
                          controller: _phoneController,
                          validator: (phone) {
                            return _authCubit.validatePhone(phone);
                          },
                          keyboardType: TextInputType.phone,
                          focusNode: _focusNodes[1],
                          onEditingComplete: () {
                            _focusNodes[1].unfocus();
                            _focusNodes[2].requestFocus();
                          },
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              child: Text(
                                '+91',
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            ),
                            hintText: 'Enter Phone',
                            border:
                                Theme.of(context).inputDecorationTheme.border,
                            enabledBorder: Theme.of(context)
                                .inputDecorationTheme
                                .enabledBorder,
                            focusedBorder: Theme.of(context)
                                .inputDecorationTheme
                                .focusedBorder,
                            errorBorder: Theme.of(context)
                                .inputDecorationTheme
                                .errorBorder,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password text form field
                        TextFormField(
                          controller: _passwordController,
                          validator: (password) {
                            return _authCubit.validatePassword(password);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_passwordVisible,
                          focusNode: _focusNodes[2],
                          onEditingComplete: () {
                            _focusNodes[2].unfocus();
                            _focusNodes[3].requestFocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            border:
                                Theme.of(context).inputDecorationTheme.border,
                            enabledBorder: Theme.of(context)
                                .inputDecorationTheme
                                .enabledBorder,
                            focusedBorder: Theme.of(context)
                                .inputDecorationTheme
                                .focusedBorder,
                            errorBorder: Theme.of(context)
                                .inputDecorationTheme
                                .errorBorder,
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
                          validator: (confirmPassword) {
                            final String password = _passwordController.text;

                            return _authCubit.validateConfirmPassword(
                              password,
                              confirmPassword,
                            );
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_confirmPasswordVisible,
                          focusNode: _focusNodes[3],
                          onEditingComplete: () {
                            _focusNodes[3].unfocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            border:
                                Theme.of(context).inputDecorationTheme.border,
                            enabledBorder: Theme.of(context)
                                .inputDecorationTheme
                                .enabledBorder,
                            focusedBorder: Theme.of(context)
                                .inputDecorationTheme
                                .focusedBorder,
                            errorBorder: Theme.of(context)
                                .inputDecorationTheme
                                .errorBorder,
                            suffixIcon: InkWell(
                              onTap: () {
                                _switchConfirmPasswordVisibility();
                              },
                              child: !_confirmPasswordVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Sign up button
                        ElevatedButton(
                          onPressed: state.loading
                              ? null
                              : () {
                                  _onSignUpButtonPressed();
                                },
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
                          onPressed: state.loading
                              ? null
                              : () {
                                  _authCubit.toggleAuthScreen();
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
              ),
            ),
          ),
        );
      },
    );
  }
}
