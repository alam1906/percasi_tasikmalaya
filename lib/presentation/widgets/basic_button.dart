import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({
    super.key,
    required this.title,
    required this.isLoading,
  });
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ))
            : Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
