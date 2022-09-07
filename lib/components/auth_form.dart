import 'dart:io';

import 'package:chat/components/use_image_picker.dart';
import 'package:chat/model/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePicker(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('imagem não selecionada!');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UseImagePicker(
                  onImagePicker: _handleImagePicker,
                  
                ),
              const SizedBox(height: 20),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('Name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    labelText: 'nome',
                  ),
                  validator: (_name) {
                    String name = _name ?? "";
                    if (name.trim().length < 5) {
                      return "O nome precisa ter pelo menos 5 caracteres.";
                    }
                    return null;
                  },
                ),
              SizedBox(height: 15),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  labelText: 'Email',
                ),
                validator: (_email) {
                  String email = _email ?? "";
                  if (!email.contains('@') || !email.contains('.com')) {
                    return 'E-mail informado não é válido.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                key: ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  labelText: 'Senha',
                ),
                validator: (_password) {
                  String password = _password ?? "";
                  if (password.length < 6) {
                    return "Sua senha precisa ter no mínimo 6 caracteres.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(350, 36),
                  shadowColor: Color.fromARGB(255, 201, 83, 16),
                  elevation: 15,
                ),
                onPressed: () {
                  _submit();
                },
              ),
              TextButton(
                child: Text(
                  _formData.isLogin ? 'Não possui conta?' : 'Já possui conta?',
                ),
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
