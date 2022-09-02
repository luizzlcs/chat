import 'package:chat/components/auth_form.dart';
import 'package:flutter/material.dart';

class AlphPage extends StatelessWidget {
  const AlphPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: SingleChildScrollView(
          child: AuthForm(),
        ),
      ),
    );
  }
}
