import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';
import 'package:percasi_tasikmalaya/domain/entities/user_model.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_image_club/update_image_club_params.dart';
import 'package:percasi_tasikmalaya/presentation/providers/all_user_data_provider/all_user_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/club/update_image_club_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/user_data_provider/user_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/basic_appbar.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/list_member.dart';

class MyClub extends ConsumerStatefulWidget {
  const MyClub({super.key});

  @override
  ConsumerState<MyClub> createState() => _MyClubState();
}

class _MyClubState extends ConsumerState<MyClub> {
  int bannerIndex = 1;
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider).valueOrNull;

    final club = ref.watch(userDataProvider.notifier).getClub();

    final allUser = ref
        .watch(allUserDataProvider.notifier)
        .getAllUserByClub(id: user!.clubId);

    return Scaffold(
        appBar: const BasicAppbar(title: "My Club"),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(club),
                const SizedBox(height: 30),
                _description(club, user),
                const SizedBox(height: 30),
                _gallery(club),
                const SizedBox(height: 30),
                _anggota(club, allUser),
              ],
            ),
          ),
        ));
  }

  _anggota(ClubModel club, List<UserModel> allUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              "Anggota",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              "More",
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300, minHeight: 200),
          child: ListView.builder(
              itemCount: allUser.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return ListMember(
                    title: allUser[index].username,
                    subTitle1: allUser[index].role,
                    subtTitle2: allUser[index].rating.toString(),
                    imageUrl: allUser[index].imageUrl!);
              }),
        ),
      ],
    );
  }

  _gallery(ClubModel club) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ))
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: StatefulBuilder(builder: (context, setState) {
            return CarouselView(
              itemExtent: 300,
              elevation: 3,
              onTap: (i) async {
                Map<String, dynamic> mapImage = club.listImageUrl ?? {};
                ImagePicker()
                    .pickImage(source: ImageSource.gallery)
                    .then((value) async {
                  if (value != null) {
                    final data = await ref.read(updateImageClubProvider).call(
                        UpdateImageClubParams(imageFile: File(value.path)));
                    if (data.isSuccess) {
                      await ref.read(clubDataProvider.notifier).updateClub(
                              club: club.copyWith(listImageUrl: {
                            ...mapImage,
                            "$i": data.resultValue
                          }));
                    } else {
                      print("Something wrong");
                    }
                  }
                });
              },
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    image: club.listImageUrl!["0"] == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              club.listImageUrl?['0'],
                            ),
                          ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: club.listImageUrl!["1"] == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              club.listImageUrl?['1'],
                            ),
                          ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    image: club.listImageUrl!["2"] == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              club.listImageUrl?['2'],
                            ),
                          ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  _description(ClubModel club, UserModel? user) {
    TextEditingController descriptionC =
        TextEditingController(text: club.description ?? '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: const Color(0xfff6f8fb),
                          title: const Text(
                            "Change Description",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          content: SizedBox(
                            width: 10000,
                            child: TextField(
                              controller: descriptionC,
                              maxLines: 6,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: "description",
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                await ref
                                    .read(clubDataProvider.notifier)
                                    .updateClub(
                                        club: club.copyWith(
                                            description: descriptionC.text));

                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Berhasil mengubah deskripsi")));
                              },
                              child: const Text("Submit"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.create,
                  color: Colors.blue,
                ))
          ],
        ),
        const SizedBox(height: 5),
        Text(
          textAlign: TextAlign.start,
          club.description ?? 'Percasi Tasikmalaya',
          style: const TextStyle(),
        ),
      ],
    );
  }

  _header(ClubModel club) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: ref.watch(userDataProvider).value?.role != 'leader'
                ? null
                : () async {
                    ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) async {
                      if (value != null) {
                        final data = await ref
                            .read(clubDataProvider.notifier)
                            .updateImage(imageFile: File(value.path));
                        await ref
                            .read(clubDataProvider.notifier)
                            .updateClub(club: club.copyWith(imageUrl: data));
                      } else {}
                    });
                  },
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              backgroundImage: club.imageUrl != null
                  ? CachedNetworkImageProvider(club.imageUrl!)
                  : null,
              child: club.imageUrl != null ? null : const Icon(Icons.add),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Manonjaya Chess Club",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "(MCC)",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
