import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percasi_tasikmalaya/core/config/utils/extension_string.dart';
import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';
import 'package:percasi_tasikmalaya/domain/entities/user_model.dart';
import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/user_data_provider/user_data_provider.dart';

import 'package:percasi_tasikmalaya/presentation/widgets/basic_appbar.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/form_textfield.dart';

class MyAccount extends ConsumerStatefulWidget {
  const MyAccount({super.key});

  @override
  ConsumerState<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends ConsumerState<MyAccount> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider).valueOrNull;
    final club = ref.read(userDataProvider.notifier).getClub();

    return Scaffold(
        appBar: const BasicAppbar(title: "My Account"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context, user, club),
                const SizedBox(height: 30),
                _profile(user)
              ],
            ),
          ),
        ));
  }

  Column _profile(UserModel? user) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            )),
        FormTextField(
          enable: false,
          title: "Username",
          hint: user!.username,
          controller: TextEditingController(),
        ),
        FormTextField(
          enable: false,
          title: "Email",
          hint: user.email,
          controller: TextEditingController(),
        ),
        FormTextField(
          enable: false,
          title: "Rating",
          hint: user.rating.toString(),
          controller: TextEditingController(),
        ),
        FormTextField(
          enable: false,
          title: "Role",
          hint: user.role,
          controller: TextEditingController(),
        ),
      ],
    );
  }

  Column _header(BuildContext context, UserModel? user, ClubModel club) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: () async {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Scaffold(
                      appBar: const BasicAppbar(title: ""),
                      body: Center(
                        child: Hero(
                          tag: 'tes',
                          child: CircleAvatar(
                            radius: 150,
                            backgroundColor: Colors.white,
                            backgroundImage: user.imageUrl != null
                                ? CachedNetworkImageProvider(user.imageUrl!)
                                : null,
                            child: user.imageUrl != null
                                ? null
                                : const Icon(Icons.add),
                          ),
                        ),
                      ),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                  reverseTransitionDuration:
                      const Duration(milliseconds: 300)));
            },
            child: Hero(
              tag: 'tes',
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage: user!.imageUrl != null
                        ? CachedNetworkImageProvider(user.imageUrl!)
                        : null,
                    child: user.imageUrl != null ? null : const Icon(Icons.add),
                  ),
                  user.role == 'leader'
                      ? Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () async {
                              ImagePicker()
                                  .pickImage(source: ImageSource.gallery)
                                  .then((value) async {
                                if (value != null) {
                                  final data = await ref
                                      .read(clubDataProvider.notifier)
                                      .updateImage(imageFile: File(value.path));
                                  await ref
                                      .read(userDataProvider.notifier)
                                      .updateUser(
                                          user: user.copyWith(imageUrl: data));
                                } else {}
                              });
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 23,
                              child: Icon(Icons.add),
                            ),
                          ))
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          user.username.capitalize(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          club.name.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
