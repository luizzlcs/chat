import 'package:chat/components/auth_form.dart';
import 'package:chat/model/auth_form_data.dart';
import 'package:flutter/material.dart';

class AlphPage extends StatefulWidget {
  const AlphPage({Key? key}) : super(key: key);

  @override
  State<AlphPage> createState() => _AlphPageState();
}

class _AlphPageState extends State<AlphPage> {
  bool _isLoading = false;

  void _handleSubmit(AuthFormData formData) {
    setState(() => _isLoading = true);
    print('AuthPage...');
    print(formData.email);

    // setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: AuthForm(onSubmit: _handleSubmit),
                ),
              ),
              if (_isLoading)
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
