import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percasi_tasikmalaya/core/config/utils/extension_string.dart';
import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/user_data_provider/user_data_provider.dart';

import 'package:percasi_tasikmalaya/presentation/widgets/basic_appbar.dart';

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
              children: [
                Column(
                  children: [
                    Center(
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
                                      user: user!.copyWith(imageUrl: data));
                            } else {}
                          });
                        },
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage: user?.imageUrl == null
                              ? null
                              : CachedNetworkImageProvider(user!.imageUrl!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user?.username.capitalize() ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      club.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
