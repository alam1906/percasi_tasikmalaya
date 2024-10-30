import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListTurnament extends StatelessWidget {
  const ListTurnament({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.tag,
  });
  final String title;
  final String imageUrl;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Scaffold(
                  body: SafeArea(
                    child: Center(
                      child: Hero(
                        tag: tag,
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 600),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: CachedNetworkImageProvider(imageUrl),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
            child: Hero(
              tag: tag,
              child: Container(
                width: double.infinity,
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(imageUrl),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "29 Oktober 2024",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
