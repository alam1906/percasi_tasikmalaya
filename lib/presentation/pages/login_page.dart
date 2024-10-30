import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/basic_appbar.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/form_textfield.dart';

import '../providers/user_data_provider/user_data_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailC;
    passC;
    isLoading;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (previous is AsyncError && next.value == null) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Gagal Login")));
        } else if (next.value != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Berhasil Login")));
        }
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.error.toString())));
      } else {
        setState(() {
          isLoading = true;
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login Page",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormTextField(title: "Email", hint: "email", controller: emailC),
              FormTextField(
                  title: "Password", hint: "password", controller: passC),
              ElevatedButton(
                onPressed: () async {
                  if (emailC.text.isEmpty || passC.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Field tidak boleh kosong")));
                  } else {
                    await ref
                        .read(userDataProvider.notifier)
                        .login(email: emailC.text, password: passC.text);
                  }
                },
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
