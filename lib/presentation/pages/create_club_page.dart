import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';

import 'package:percasi_tasikmalaya/presentation/widgets/basic_appbar.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/basic_button.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/form_textfield.dart';

class CreateClubPage extends ConsumerStatefulWidget {
  const CreateClubPage({super.key});

  @override
  ConsumerState<CreateClubPage> createState() => _CreateClubPageState();
}

class _CreateClubPageState extends ConsumerState<CreateClubPage> {
  final TextEditingController nameC = TextEditingController();
  final TextEditingController fullNameC = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    nameC;
    fullNameC;
    isLoading;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(clubDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (previous is AsyncError) {
        } else {
          setState(() {
            isLoading = !isLoading;
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Berhasil menambahkan club")));
        }
      } else if (next is AsyncError) {
      } else {
        setState(() {
          isLoading = !isLoading;
        });
      }
    });
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: const BasicAppbar(title: "Create Club"),
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
          title: "Name",
          hint: "MCC, KCC, SCC, etc.",
          controller: nameC,
        ),
        FormTextField(
          title: "Full Name",
          hint: "full name",
          controller: fullNameC,
        ),
        GestureDetector(
            onTap: () async {
              if (nameC.text.isEmpty || fullNameC.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Field harus diisi")));
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
                await ref.read(clubDataProvider.notifier).addClub(
                    name: nameC.text.toLowerCase(),
                    fullName: fullNameC.text.toLowerCase());
              }
            },
            child: BasicButton(title: "Register", isLoading: isLoading)),
      ],
    );
  }
}
