import 'package:flutter/material.dart';

class DetailNews extends StatelessWidget {
  const DetailNews({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.url,
  });
  final String title;
  final String date;
  final String description;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f8fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(url))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        description,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
