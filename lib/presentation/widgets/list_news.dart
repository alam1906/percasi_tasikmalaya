import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListNews extends StatelessWidget {
  const ListNews({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.onTap,
  });
  final String title;
  final String subTitle;
  final String? imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
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
                  width: 140,
                  height: 100,
                  decoration: BoxDecoration(
                      image: imageUrl != null
                          ? DecorationImage(
                              image: CachedNetworkImageProvider(imageUrl!),
                              fit: BoxFit.fitWidth)
                          : null,
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
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
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        subTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
