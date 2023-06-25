import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saffar_app/features/authentication/presenter/cubit/auth_cubit.dart';
import 'package:saffar_app/features/authentication/presenter/view/sign_up_screen.dart';

import '../../../../core/constants/nums.dart';
import '../../../../core/palette.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const String routeName = '/sign_in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final AuthCubit _authCubit;

  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  late final GlobalKey<FormState> _formKey;

  bool _passwordVisible = false;

  void _switchPasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    _authCubit = AuthCubit();

    _phoneController = TextEditingController();
    _passwordController = TextEditingController();

    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();

    _authCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>.value(
      value: _authCubit,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              return !state.loading;
            },
            child: Scaffold(
                body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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

                        // Phone text form field
                        TextFormField(
                          controller: _phoneController,
                          validator: (phone) {
                            return _authCubit.validatePhone(phone);
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Enter Phone',
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.outline),
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
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.outline),
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
                        const SizedBox(height: 32),

                        // Sign in button
                        ElevatedButton(
                          onPressed: state.loading
                              ? null
                              : () {
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!.validate()) {
                                    final String phone = _phoneController.text;
                                    final String password =
                                        _passwordController.text;

                                    _authCubit.signIn(context, phone, password);
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.bold),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                          child: Center(
                            child: Text(
                              state.loading ? '...' : 'Sign In',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Or
                        const Text('Or'),

                        // Sign up button
                        TextButton(
                          onPressed: state.loading
                              ? null
                              : () {
                                  // Navigates to sign up screen while replacing the current
                                  // screen with sign up screen
                                  Navigator.pushReplacementNamed(
                                    context,
                                    SignUpScreen.routeName,
                                  );
                                },
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
              ),
            )),
          );
        },
      ),
    );
  }
}