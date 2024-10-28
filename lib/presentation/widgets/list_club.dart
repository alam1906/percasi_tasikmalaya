// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListClub extends StatelessWidget {
  const ListClub({
    super.key,
    required this.title,
    required this.subTitle1,
    required this.subTitle2,
    required this.imageUrl,
  });
  final String title;
  final String subTitle1;
  final String subTitle2;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: imageUrl == null
                        ? Colors.white
                        : const Color(0xfff6f8fb),
                    borderRadius: BorderRadius.circular(20)),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: imageUrl == null
                      ? null
                      : CachedNetworkImageProvider(imageUrl!),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Member : $subTitle1",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Prestasi : $subTitle2",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: 1,
          height: 10,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}
