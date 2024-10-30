import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';
import 'package:percasi_tasikmalaya/domain/entities/user_model.dart';

import 'package:percasi_tasikmalaya/presentation/providers/all_user_data_provider/all_user_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';

import 'package:percasi_tasikmalaya/presentation/providers/user_data_provider/user_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/basic_appbar.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/list_member.dart';

class MyClub extends ConsumerStatefulWidget {
  const MyClub({super.key});

  @override
  ConsumerState<MyClub> createState() => _MyClubState();
}

class _MyClubState extends ConsumerState<MyClub> {
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
                _header(club, user),
                const SizedBox(height: 30),
                _description(club, user),
                const SizedBox(height: 30),
                Gallery(
                  club: club,
                  user: user,
                ),
                const SizedBox(height: 30),
                _anggota(club, allUser),
              ],
            ),
          ),
        ));
  }

  _anggota(ClubModel club, List<UserModel?> allUser) {
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
                if (allUser.isEmpty) {
                  return const SizedBox();
                }
                return ListMember(
                  hero: allUser[index]!.uid,
                  title: allUser[index]!.username,
                  subTitle1: allUser[index]!.role,
                  subtTitle2: allUser[index]!.rating.toString(),
                  imageUrl: allUser[index]!.imageUrl!,
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
            user!.role == 'leader'
                ? IconButton(
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
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
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
                                                description:
                                                    descriptionC.text));

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
                : const SizedBox(),
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

  _header(ClubModel club, UserModel? user) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Scaffold(
                    appBar: const BasicAppbar(title: ""),
                    body: Center(
                      child: Hero(
                        tag: 'tes',
                        child: CircleAvatar(
                          radius: 150,
                          backgroundColor: Colors.white,
                          backgroundImage: club.imageUrl != null
                              ? CachedNetworkImageProvider(club.imageUrl!)
                              : null,
                          child: club.imageUrl != null
                              ? null
                              : const Icon(Icons.add),
                        ),
                      ),
                    ),
                  );
                },
                transitionDuration: const Duration(milliseconds: 300))),
            child: Hero(
              tag: 'tes',
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage: club.imageUrl != null
                        ? CachedNetworkImageProvider(club.imageUrl!)
                        : null,
                  ),
                  user!.role == 'leader'
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
                                      .read(clubDataProvider.notifier)
                                      .updateClub(
                                          club: club.copyWith(imageUrl: data));
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
          club.fullName.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "(${club.name})".toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class Gallery extends ConsumerStatefulWidget {
  const Gallery({
    super.key,
    required this.club,
    required this.user,
  });
  final ClubModel club;
  final UserModel? user;

  @override
  ConsumerState<Gallery> createState() => _GalleryState();
}

class _GalleryState extends ConsumerState<Gallery> {
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Gallery",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            widget.user!.role == 'leader'
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isEdit = !isEdit;
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      color: isEdit ? Colors.red : Colors.blue,
                    ))
                : const SizedBox(),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 270,
          child: StatefulBuilder(builder: (context, setState) {
            return GridView.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    isEdit == false
                        ? Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return Scaffold(
                                  appBar: const BasicAppbar(title: ''),
                                  body: Center(
                                    child: Hero(
                                      tag: index,
                                      child: Container(
                                        height: 300,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: widget.club.listImageUrl![
                                                      '$index'] ==
                                                  null
                                              ? null
                                              : DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          widget.club
                                                                  .listImageUrl![
                                                              '$index']),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 200),
                            ),
                          )
                        : ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then((value) async {
                            if (value != null) {
                              final data = await ref
                                  .read(clubDataProvider.notifier)
                                  .updateImage(imageFile: File(value.path));
                              await ref
                                  .read(clubDataProvider.notifier)
                                  .updateClub(
                                    club: widget.club.copyWith(
                                      listImageUrl: {
                                        ...widget.club.listImageUrl!,
                                        "$index": data
                                      },
                                    ),
                                  );
                            }
                          });
                  },
                  child: Hero(
                    tag: index,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        image: widget.club.listImageUrl!['$index'] == null
                            ? null
                            : DecorationImage(
                                opacity: isEdit ? 0.2 : 1.0,
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    widget.club.listImageUrl!['$index']),
                              ),
                      ),
                      child: isEdit
                          ? const Icon(
                              Icons.add,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
