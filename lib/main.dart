import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/config/theme/app_theme.dart';

import 'presentation/pages/auth_gate.dart';

import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const AuthGate());
  }
}
