// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    super.key,
    required this.hint,
  });
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
