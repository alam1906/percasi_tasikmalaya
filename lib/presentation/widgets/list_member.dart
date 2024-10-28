// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListMember extends StatelessWidget {
  const ListMember({
    super.key,
    required this.title,
    required this.subTitle1,
    required this.subtTitle2,
    required this.imageUrl,
  });
  final String title;
  final String subTitle1;
  final String subtTitle2;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(imageUrl)),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textAlign: TextAlign.start,
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      subTitle1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                subtTitle2,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
