import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gifthub/layer/presentation/provider/domain.provider.dart';

import 'package:gifthub/layer/presentation/view/sign_up/sign_up.page.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.page.dart';

class SignInContent extends ConsumerStatefulWidget {
  const SignInContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInContentState();
}

class _SignInContentState extends ConsumerState<SignInContent> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onSignInPressed(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('아이디를 입력해주세요.'),
        ),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('비밀번호를 입력해주세요.'),
        ),
      );
      return;
    }

    final result = await ref.read(signInProvider)(username, password);
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('로그인에 성공했습니다.'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VoucherListPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('로그인에 실패했습니다.'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 32),
              Text(
                '로그인',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: '아이디',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _onSignInPressed(context),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 48),
                    ),
                  ),
                  child: const Text('로그인'),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  ),
                  child: Text('회원이 아니라면 회원가입 하러가기',
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
