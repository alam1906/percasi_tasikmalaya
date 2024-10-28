import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/user_data_provider/user_data_provider.dart';

import 'package:percasi_tasikmalaya/presentation/widgets/basic_appbar.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/basic_button.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/form_textfield.dart';

class CreateMemberPage extends ConsumerStatefulWidget {
  const CreateMemberPage({super.key});

  @override
  ConsumerState<CreateMemberPage> createState() => _CreateMemberPageState();
}

class _CreateMemberPageState extends ConsumerState<CreateMemberPage> {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  final TextEditingController usernameC = TextEditingController();
  final TextEditingController ratingC = TextEditingController();

  final TextEditingController passAdminC = TextEditingController();
  String? clubId;
  String? nameClub;
  bool visibility = false;
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      clubId = ref.read(userDataProvider).value!.clubId;
      final data = ref
          .read(clubDataProvider)
          .value!
          .where((e) => e.id.contains(clubId!))
          .toList();
      nameClub = data.first.name;
    });

    super.initState();
  }

  @override
  void dispose() {
    emailC;
    passC;
    usernameC;
    ratingC;
    clubId;
    passAdminC;
    visibility;
    isLoading;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (previous is AsyncError) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Gagal mendaftarkan user")));
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Berhasil mendaftarkan user")));
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: const BasicAppbar(title: "Create Member"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: _textFormField(context),
            ),
          )),
    );
  }

  _textFormField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTextField(
          title: "Username",
          hint: "username",
          controller: usernameC,
        ),
        FormTextField(
          title: "Email",
          hint: "email adress",
          controller: emailC,
        ),
        StatefulBuilder(builder: (context, setState) {
          return FormTextField(
            iconData: visibility
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onTap: () {
              setState(() {
                visibility = !visibility;
              });
            },
            hide: visibility ? false : true,
            title: "Password",
            hint: "password",
            controller: passC,
          );
        }),
        FormTextField(
          enable: false,
          title: "Club",
          hint: nameClub!,
          controller: TextEditingController(),
        ),
        FormTextField(
          keyboardType: TextInputType.number,
          title: "Rating",
          hint: "rating",
          controller: ratingC,
        ),
        GestureDetector(
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (emailC.text.isEmpty ||
                  passC.text.isEmpty ||
                  ratingC.text.isEmpty ||
                  usernameC.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Field harus diisi")));
              } else {
                _showDialog(context);
              }
            },
            child: BasicButton(title: "Register", isLoading: isLoading)),
      ],
    );
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xfff6f8fb),
            title: const Text(
              "Masukan password untuk konfirmasi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: TextField(
              cursorHeight: 20,
              controller: passAdminC,
              decoration: InputDecoration(
                hintText: "password",
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    if (passAdminC.text.isNotEmpty) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                      await ref.read(userDataProvider.notifier).registerMember(
                            email: emailC.text.toLowerCase(),
                            password: passC.text.toLowerCase(),
                            clubId: clubId!,
                            imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/percasitasikmalaya.appspot.com/o/news%2Fimages.jpg?alt=media&token=d4331b76-dbc4-418a-a9b8-24b2ffe4cbb6',
                            rating: int.parse(ratingC.text),
                            username: usernameC.text.toLowerCase(),
                            passwordAdmin: passAdminC.text.toLowerCase(),
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Password admin harus diisi")));
                    }
                  },
                  child: const Text("Submit")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
            ],
          );
        });
  }
}
