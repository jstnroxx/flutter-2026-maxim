import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_api/core/api/api_exception.dart';
import 'package:users_api/features/users/user.dart';

import 'users_model.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({super.key});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _email.dispose();
    super.dispose();
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final String? missing = _required(value, 'Email');
    if (missing != null) {
      return missing;
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value!.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  String _messageFor(ApiException e) {
    return switch (e) {
      NoConnectionException() => 'No connection. Try again.',
      ServerException(:final int status) =>
        'Server error ($status). Try again.',
      NotFoundException() => 'Not found.',
      UnauthorizedException() => 'Not authorized.',
      BadResponseException() => 'Unexpected response from the server.',
    };
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _submitting = true;
    });

    final User draft = User(
      id: 0,
      name: _name.text.trim(),
      username: _username.text.trim(),
      email: _email.text.trim(),
      phone: '',
      website: null,
      address: const Address(
        street: '',
        suite: '',
        city: '',
        zipcode: '',
        geo: Geo(lat: 0, lng: 0),
      ),
      company: (name: '', catchPhrase: ''),
    );

    final ApiException? error = await context.read<UsersModel>().create(draft);

    if (!mounted) {
      return;
    }

    if (error == null) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _submitting = false;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(_messageFor(error))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New user')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (String? v) => _required(v, 'Name'),
              ),
              TextFormField(
                controller: _username,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (String? v) => _required(v, 'Username'),
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _submitting ? null : _save,
                child: _submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
