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

class DetailClub extends ConsumerStatefulWidget {
  const DetailClub({
    super.key,
    required this.clubModel,
  });
  final ClubModel clubModel;

  @override
  ConsumerState<DetailClub> createState() => _DetailClubState();
}

class _DetailClubState extends ConsumerState<DetailClub> {
  int bannerIndex = 1;
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider).valueOrNull;
    final result = ref
        .read(allUserDataProvider.notifier)
        .getAllUserByClub(id: widget.clubModel.id);
    return Scaffold(
        appBar: const BasicAppbar(title: "Detail Club"),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                const SizedBox(height: 30),
                _description(),
                const SizedBox(height: 30),
                Gallery(club: widget.clubModel, user: user),
                const SizedBox(height: 30),
                _anggota(result),
              ],
            ),
          ),
        ));
  }

  _anggota(List<UserModel> result) {
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
        result.isEmpty
            ? const Column(
                children: [
                  Center(child: Text("Tidak ada data")),
                  SizedBox(height: 100)
                ],
              )
            : ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 300, minHeight: 200),
                child: ListView.builder(
                    itemCount: result.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ListMember(
                        hero: result[index].uid,
                        title: result[index].username,
                        subTitle1: result[index].role,
                        subtTitle2: result[index].rating.toString(),
                        imageUrl: result[index].imageUrl!,
                      );
                    }),
              ),
      ],
    );
  }

  _description() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          textAlign: TextAlign.start,
          "Going out tonight change into the something red, her mother doesn't like that kind of dress, everything she never had she's showing off, driving too fast moon is breaking through her hair.",
          style: TextStyle(),
        ),
      ],
    );
  }

  _header() {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: () => Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Scaffold(
                  body: Center(
                    child: Hero(
                      tag: widget.clubModel.id,
                      child: CircleAvatar(
                        radius: 150,
                        backgroundColor: Colors.white,
                        backgroundImage: widget.clubModel.imageUrl == null
                            ? null
                            : CachedNetworkImageProvider(
                                widget.clubModel.imageUrl!),
                      ),
                    ),
                  ),
                );
              },
            )),
            child: Hero(
              tag: widget.clubModel.id,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                backgroundImage: widget.clubModel.imageUrl == null
                    ? null
                    : CachedNetworkImageProvider(widget.clubModel.imageUrl!),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.clubModel.fullName.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "(${widget.clubModel.name})".toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
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
        const Row(
          children: [
            Text(
              "Gallery",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
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
                                    borderRadius: BorderRadius.circular(10),
                                    image: widget
                                                .club.listImageUrl!['$index'] ==
                                            null
                                        ? null
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                                widget.club
                                                    .listImageUrl!['$index']),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 200),
                      ),
                    );
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
