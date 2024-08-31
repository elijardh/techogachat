import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techogachat/screens/home_screen/home_screen.dart';
import 'package:techogachat/screens/sign_in_screen/sign_in_screen_view_model.dart';
import 'package:techogachat/screens/sign_up_screen/sign_up_screen.dart';
import 'package:techogachat/shared/button.dart';
import 'package:techogachat/shared/input_field.dart';
import 'package:techogachat/utils/extensions.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInScreenViewModel(),
      child: Consumer<SignInScreenViewModel>(
        builder: (context, value, child) => Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputField(
                      textEditingController: _emailController,
                      hint: 'test@gmail.com',
                      label: 'Email',
                    ),
                    20.vSpace,
                    InputField(
                      textEditingController: _passwordController,
                      hint: '*******',
                      label: 'Password',
                    ),
                    20.vSpace,
                    Button(
                      buttonName: 'Sign In',
                      loading: value.loading,
                      onTap: () => value.signIn(
                        _emailController.text,
                        _passwordController.text,
                        () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        )),
                      ),
                    ),
                    40.vSpace,
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      )),
                      child: const Text(
                        'Create an Account',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
