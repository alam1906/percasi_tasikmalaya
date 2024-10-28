import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_page.dart';
import 'login_page.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  late final Stream<User?> _data;
  @override
  void initState() {
    _data = FirebaseAuth.instance.authStateChanges();
    super.initState();
  }

  @override
  void dispose() {
    _data;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        });
  }
}
