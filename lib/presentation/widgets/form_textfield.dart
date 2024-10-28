import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    this.hide,
    this.onTap,
    this.iconData,
    this.keyboardType,
    this.enable,
    this.maxLines,
    this.padding,
  });
  final bool? enable;
  final TextInputType? keyboardType;
  final Icon? iconData;
  final bool? hide;
  final VoidCallback? onTap;
  final String title;
  final String hint;
  final TextEditingController controller;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " $title",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          cursorHeight: 20,
          maxLines: maxLines ?? 1,
          enabled: enable == null ? true : false,
          keyboardType: keyboardType ?? TextInputType.multiline,
          obscureText: hide ?? false,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: iconData == null
                ? null
                : IconButton(onPressed: onTap, icon: iconData!),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: padding ?? const EdgeInsets.fromLTRB(15, 0, 15, 0),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
