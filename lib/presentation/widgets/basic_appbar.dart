import 'package:flutter/material.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppbar({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            )),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
