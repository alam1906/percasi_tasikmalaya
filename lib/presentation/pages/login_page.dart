import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_data_provider/user_data_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                await ref
                    .read(userDataProvider.notifier)
                    .login(email: 'alam@gmail.com', password: 'alam123');
              },
              child: const Text("Login"))),
    );
  }
}
