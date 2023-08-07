import 'package:flutter/material.dart';

import 'package:gifthub/layer/presentation/view/sign_up/sign_up.view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignUpView(),
    );
  }
}
