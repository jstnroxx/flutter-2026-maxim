import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_api/auth_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();

  bool _busy = false;

  void _submit(AuthModel auth) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _busy = true;
      });

      await auth.login(_email.text.trim(), _password.text);

      if (!mounted) return;
      setState(() {
        _busy = false;
      });
    }
  }

  @override
  void dispose() {
    for (final c in [
      _email,
      _password,
      _confirm,
      _emailFocusNode,
    ]) {
      c.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthModel auth = context.watch<AuthModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) {
                      final String email = (value ?? '').trim();

                      if (!email.contains('@') ||
                          email.indexOf('.', email.indexOf('@')) <=
                              email.indexOf('@')) {
                        return 'Email looks wrong';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocusNode,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'name@kbtu.kz',
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _password,
                    validator: (value) {
                      if ((value ?? '')
                          .trim()
                          .length < 8) {
                        return 'Password is too short';
                      }

                      return null;
                    },
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      helperText: _password.text.isEmpty
                          ? 'At least 8 characters'
                          : '${_password.text.length} of 8+',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _confirm,
                    validator: (value) {
                      if ((value ?? '').trim() != _password.text.trim()) {
                        return 'Passwords do not match';
                      }

                      return null;
                    },
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: _busy ? null : (_) => _submit(auth),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: const InputDecoration(
                      labelText: 'Confirm password',
                    ),
                  ),
                ),
              ),
              FilledButton(
                onPressed: _busy ? null : () => _submit(auth),
                child: Text('Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}