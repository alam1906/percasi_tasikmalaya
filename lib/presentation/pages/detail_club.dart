import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';
import 'package:percasi_tasikmalaya/presentation/providers/all_user_data_provider/all_user_data_provider.dart';
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

  final _bannerController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
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
                _gallery(),
                const SizedBox(height: 30),
                _anggota(result),
              ],
            ),
          ),
        ));
  }

  _anggota(result) {
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

  _gallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gallery",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: StatefulBuilder(builder: (context, setState) {
            return CarouselView(
              itemExtent: 300,
              elevation: 3,
              onTap: (i) async {},
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    image: widget.clubModel.listImageUrl!["0"] == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              widget.clubModel.listImageUrl?['0'],
                            ),
                          ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: widget.clubModel.listImageUrl!["1"] == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              widget.clubModel.listImageUrl?['1'],
                            ),
                          ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    image: widget.clubModel.listImageUrl!["2"] == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              widget.clubModel.listImageUrl?['2'],
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
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            backgroundImage: widget.clubModel.imageUrl == null
                ? null
                : CachedNetworkImageProvider(widget.clubModel.imageUrl!),
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
