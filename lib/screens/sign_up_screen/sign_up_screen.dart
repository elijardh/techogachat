import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techogachat/screens/payment_screen/payment_screen.dart';
import 'package:techogachat/screens/sign_up_screen/sign_up_screen_view_model.dart';
import 'package:techogachat/shared/shared.dart';
import 'package:techogachat/utils/extensions.dart';
import 'package:techogachat/view_models/auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  late final _auth = Provider.of<Auth>(context, listen: false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();

    _emailNode.dispose();
    _passwordNode.dispose();
    _nameNode.dispose();
    _phoneNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _nameNode.requestFocus();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpScreenViewModele(),
      child: Consumer<SignUpScreenViewModele>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Sign Up'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  30.vSpace,
                  InputField(
                    textEditingController: _nameController,
                    hint: 'John Doe',
                    label: 'Name',
                    node: _nameNode,
                    onEditingComplete: (_) => _emailNode.requestFocus(),
                    validator: (val) => val == null || val.isEmpty
                        ? 'Input a valid value'
                        : null,
                  ),
                  20.vSpace,
                  InputField(
                    textEditingController: _emailController,
                    hint: 'trest@gmail.com',
                    label: 'Email',
                    node: _emailNode,
                    onEditingComplete: (_) => _phoneNode.requestFocus(),
                    validator: (val) => val == null || val.isEmpty
                        ? 'Input a valid value'
                        : null,
                  ),
                  20.vSpace,
                  InputField(
                    textEditingController: _phoneNumberController,
                    hint: '123456789 Doe',
                    label: 'Phone Number',
                    node: _phoneNode,
                    onEditingComplete: (_) => _passwordNode.requestFocus(),
                    validator: (val) => val == null || val.isEmpty
                        ? 'Input a valid value'
                        : null,
                  ),
                  20.vSpace,
                  InputField(
                    textEditingController: _passwordController,
                    hint: '*******',
                    label: 'Password',
                    node: _passwordNode,
                    validator: (val) => val == null || val.isEmpty
                        ? 'Input a valid value'
                        : null,
                  ),
                  20.vSpace,
                  Button(
                      buttonName: 'Sign Up',
                      loading: value.loading,
                      onTap: () {
                        if (_key.currentState!.validate()) {
                          //Perform our action here

                          value.createUser(
                            name: _nameController.text,
                            password: _passwordController.text,
                            phoneNumber: _passwordController.text,
                            email: _emailController.text,
                            onSuccess: (user) {
                              _auth.setUser(user);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PaymentScreen(),
                              ));
                            },
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
