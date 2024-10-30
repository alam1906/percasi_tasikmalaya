import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percasi_tasikmalaya/presentation/providers/turnament_data_provider/turnament_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/basic_appbar.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/basic_button.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/form_textfield.dart';

class CreateTurnamentPage extends ConsumerStatefulWidget {
  const CreateTurnamentPage({super.key});

  @override
  ConsumerState<CreateTurnamentPage> createState() =>
      _CreateTurnamentPageState();
}

class _CreateTurnamentPageState extends ConsumerState<CreateTurnamentPage> {
  final titleC = TextEditingController();

  File? imageFile;
  bool isLoading = false;

  @override
  void dispose() {
    titleC;

    imageFile;
    isLoading;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      turnamentDataProviderProvider,
      (previous, next) {
        if (next is AsyncData) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Berhasil menambahkan data")));
          Navigator.pop(context);
        } else if (next is AsyncError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.error.toString())));
        } else {
          setState(() {
            isLoading = true;
          });
        }
      },
    );
    return Scaffold(
        appBar: const BasicAppbar(title: "Create Turnament"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      ImagePicker()
                          .pickImage(source: ImageSource.gallery)
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            imageFile = File(value.path);
                          });
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          image: imageFile != null
                              ? DecorationImage(
                                  image: FileImage(imageFile!),
                                  fit: BoxFit.fitWidth)
                              : null),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                FormTextField(
                  maxLines: 1,
                  title: "Title",
                  hint: "",
                  controller: titleC,
                ),
                GestureDetector(
                  onTap: () async {
                    if (imageFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Gambar harus diisi")));
                    } else {
                      FocusManager.instance.primaryFocus?.unfocus();
                      await ref
                          .read(turnamentDataProviderProvider.notifier)
                          .addTurnament(
                              title: titleC.text, imageFile: imageFile!);
                    }
                  },
                  child: BasicButton(title: "Add", isLoading: isLoading),
                )
              ],
            ),
          ),
        ));
  }
}
