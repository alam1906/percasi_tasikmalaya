import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percasi_tasikmalaya/presentation/providers/news_data_provider/news_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/basic_appbar.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/basic_button.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/form_textfield.dart';

class CreateNewsPage extends ConsumerStatefulWidget {
  const CreateNewsPage({super.key});

  @override
  ConsumerState<CreateNewsPage> createState() => _CreateNewsPageState();
}

class _CreateNewsPageState extends ConsumerState<CreateNewsPage> {
  final titleC = TextEditingController();
  final descriptionC = TextEditingController();
  File? imageFile;
  bool isLoading = false;

  @override
  void dispose() {
    titleC;
    descriptionC;
    imageFile;
    isLoading;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(newsDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (previous is AsyncError) {
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Berhasil menambahkan berita")));
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
        appBar: const BasicAppbar(title: "Create News Page"),
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
                        setState(() {
                          imageFile = File(value!.path);
                        });
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
                FormTextField(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  maxLines: 6,
                  title: "Description",
                  hint: "",
                  controller: descriptionC,
                ),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await ref.read(newsDataProvider.notifier).addNews(
                        title: titleC.text,
                        description: descriptionC.text,
                        imageFile: imageFile!);
                  },
                  child: BasicButton(title: "Add", isLoading: isLoading),
                )
              ],
            ),
          ),
        ));
  }
}
